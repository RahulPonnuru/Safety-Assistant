#ifndef _Flame_H_
#define _Flame_H_
#include "variables.h"
#define DEBUG

void Flame() {
  output = digitalRead(sensor);
  if (output == 0) {
    counter2++;
    if (counter2 >= 10) {
      flag2 = 1;
      counter2 = 0;
    }
#ifdef DEBUG
    Serial.print(output);
    Serial.print("FIRE DETECTED!");
#endif
    digitalWrite(LED, HIGH);
//    send_event("FIRE DETECTION");
    if (flag2 == 1) {
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
      flag2 = 0;
    }
  }
  digitalWrite(LED, LOW);
}

#endif
