<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\MessageBag;

class UserController extends Controller {

    public function register() {

        return view('register');
    }

    public function postRegister(Request $request) {
        // dd($request->all());
        $validator = Validator::make($request->all(), [
                    'email' => 'required|email',
                    'tel' => 'required',
                    'password' => 'required|min:5',
                    'name' => 'required',
                        ], [
                        // 'email.required'=>'email sai'
        ]);
        if ($validator->fails()) {
            // dd($validator->errors());
            return redirect()->route('register')->withErrors($validator);
        } else {
            DB::table('users')->insert([
                'email' => $request->email,
                'phone' => $request->tel,
                'password' => bcrypt($request->password),
                'name' => $request->name,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s'),
            ]);
            return redirect()->route('register')->with('success', 'Đăng ký thành công');
        }
    }

    public function getLogin() {

        if (Auth::check()) {
            return redirect()->route('index');
        }

        return view('login');
    }

    public function login_post(Request $request) {
        $rules = [
            'email' => 'required|email',
            'password' => 'required|min:5'
        ];
        $messages = [
            'email.required' => 'Email là trường bắt buộc',
            'email.email' => 'Email không đúng định dạng',
            'password.required' => 'Mật khẩu là trường bắt buộc',
            'password.min' => 'Mật khẩu phải chứa ít nhất 5 ký tự',
        ];

        $validator = Validator::make($request->all(), $rules, $messages);




        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        } else {
            $email = $request->input('email');
            $password = $request->input('password');
            $active = DB::table('users')->select('active')->Where('email', $email)->get();
            $ac = $active[0]->active;

            $dateTime = DB::table('users')->select('last_access')->Where('email', $email)->get();
            $dat = $dateTime[0]->last_access;
           
          
            if ($ac == 0) {

                if (Auth::attempt(['email' => $email, 'password' => $password])) {
                    if ($dat == null) {
                        DB::table('users')
                                ->where('email', $email)
                                ->update(['attempt' => 0]);
                        return redirect()->intended('/');
                    }
                    if ( $dat > ($dat + 10800)) {
                        DB::table('users')
                                ->where('email', $email)
                                ->update(['attempt' => 0, 'active' => 0]);
                        return redirect()->intended('/');
                    } else {
                        $block = new MessageBag(['errorlogin' => 'Tài khoản của bạn đã bị khóa trong 30p.!!!']);
                        return redirect()->back()->withInput()->withErrors($block);
                    }
                } else {
                    $attempt = DB::table('users')->select('attempt')->Where('email', 'lecong@gmail.com')->get();
                    $a = $attempt[0]->attempt;
                    DB::table('users')
                            ->where('email', $email)
                            ->update(['attempt' => ++$a]);

                    if ($a >= 3) {
                        DB::table('users')
                                ->where('email', $email)
                                ->update(['active' => 1
                                    , 'last_access' =>  time()]);

                        $block = new MessageBag(['errorlogin' => 'Tài khoản của bạn đã bị khóa trong 30p.!!!']);

                        return redirect()->back()->withInput()->withErrors($block);
                    }

                    $errors = new MessageBag(['errorlogin' => 'Email hoặc mật khẩu không đúng']);
                    return redirect()->back()->withInput()->withErrors($errors);
                }
            }
        }
    }

    public function logout() {
        Auth::logout();
        return redirect()->route('index');
    }

    public function edit_profile() {
        $user = Auth::user();
        return view('edit_profile', compact('user'));
    }

    public function edit_profile_post(Request $request) {

        if ($request->password != null) {
            DB::table('users')->update([
                'password' => bcrypt($request->password),
                // 'email'=>$request->email,
                'phone' => $request->tel,
                'name' => $request->name,
                'updated_at' => date('Y-m-d H:i:s'),
            ]);
        } else {
            DB::table('users')->update([
                // 'email'=>$request->email,
                'phone' => $request->tel,
                'name' => $request->name,
                'updated_at' => date('Y-m-d H:i:s'),
            ]);
        }

        return redirect()->route('edit-profile')->with('success', ' Cập nhật thành công');
    }

}
