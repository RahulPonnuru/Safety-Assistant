#ifndef _variables_H_
#define _variables_H_

#include "twilio.hpp"

const int sensor = 5;          // Flame Sensor at D5
const int LED = 34;            // LED at D34
const int Gas_analog = 4;      // Gas Sensor analog read at D4
const int Gas_digital = 2;     // Gas Sensor digital read at D2
const int Buzzer = 35;         // Buzzer at D35
unsigned long timer = 0;
int output = 0;

MPU6050 mpu(Wire);

int roll  = 0;                  // roll for x plane orientation
int counter = 0;                // counter for checking if the orientation is beyond 85 degrees for more than 10 seconds
int flag = 0;                   // flag to check if an accident has occured or not
int counter2 = 0;               // counter for checking Flame
int flag2 = 0;                  // flag to check if an accident has occured or not
int counter3 = 0;               // counter for checking Gas
int flag3 = 0;                  // flag to check if an accident has occured or not

static const char *ssid = "Pawar";                                         // SSID of nearby Internet
static const char *password = "7620881451";                                         // Password of nearby Internet

// Values from Twilio (find them on the dashboard)
static const char *account_sid = "";            // Unique Account ID of Twilio (Different for every user)
static const char *auth_token = "";               // Authentication Token of Twilio

// Phone number should start with "+<countrycode>"
static const char *from_number = "";

// Phone number should start with "+<countrycode>"
static const char *to_number = "";                                   // Number where to send SOS
static const char *message = "ALERT!I met with an accident at <map link> please help me out!";

String response;

Twilio *twilio;

#endif
