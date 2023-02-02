#ifndef _gasSensor_H_
#define _gasSensor_H_
#include "variables.h"
#define DEBUG

void gasSensor() {
  int gassensorAnalog  = analogRead(Gas_analog);
  int gassensorDigital = digitalRead(Gas_digital);

#ifdef DEBUG
  Serial.print("Gas Sensor: ");
  Serial.print(gassensorAnalog);
  Serial.print("\t");
  Serial.print("Gas Class: ");
  Serial.print(gassensorDigital);
  Serial.print("\t");
  Serial.print("\t");
#endif

  if (gassensorAnalog > 1000) {

    counter3++;
    if (counter3 >= 10) {
      flag3 = 1;
      counter3 = 0;
    }

#ifdef DEBUG
    Serial.println("Gas");
#endif

    digitalWrite (Buzzer, HIGH) ; //send tone
    delay(1000);
    digitalWrite (Buzzer, LOW) ;  //no tone
    delay(1000);
  }

  else {

#ifdef DEBUG
    Serial.println("No Gas");
#endif

  }
  delay(100);
  if (flag3 == 1) {
    bool success = twilio->send_message(to_number, from_number, message, response);
    if (success) {

#ifdef DEBUG
      Serial.println("Sent message successfully!");
#endif

    } else {

#ifdef DEBUG
      Serial.println(response);
#endif

    }

    flag3 = 0;
  }
}

#endif
