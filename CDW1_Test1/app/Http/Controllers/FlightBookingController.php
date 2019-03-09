<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Http\Models\Flight;
use App\Http\Models\Province;
use App\Http\Models\Passanger;


class FlightBookingController extends Controller
{
    
    public function getBookingFlight(Request $request)
    {
        $person = intval($request->get('person'));
        $temp = 1;
        
        $flight = Flight::find($request->get('id'));
        $price = $flight->flight_price *  $person;
        $sum_price = number_format($price);
        if (Auth::check())
        {
            $users_id = Auth::user()->id;
            $user = DB::table('users')->where('id','=', $users_id)->get();
            return view('flight-book', compact('person','sum_price','flight','user'));
            
        }; 
       return view('flight-book', compact('person','sum_price','flight','user'));
      
    }
    public function bookingFlight(Request $request)
    {
        $passenger =  $request->passenger;
        $flight_id =$request->flight_id;
        $flight_price = $request->flight_price;
        if (Auth::check())
        {
            $user_id = Auth::user()->id;
            for( $i = 0 ; $i< count ($passenger) ; $i++){
         
                DB::table('passanger')->insert([
                    [
                    'passanger_title' => $passenger[$i]["title"], 
                    'passanger_firstname' =>  $passenger[$i]["first_name"],
                    'passanger_lastname'=> $passenger[$i]["last_name"],
                    'passanger_user_id'=> $user_id
                    ]
                ]);
                
                
            };
            DB::table('booking')->insert([
                    
                ['booking_user_id' =>$user_id , 
                'booking_passangers' => count ($passenger) ,
                'booking_flight_id'=>$flight_id,
                'booking_price'=>(int)$flight_price
                ]
            ]);
            return redirect()->route('get-booking-flight');
            
        }; 
        return redirect()->route('login-get');
       
        
        
    }
}
