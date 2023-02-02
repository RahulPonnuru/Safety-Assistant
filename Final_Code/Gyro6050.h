#ifndef _Gyro6050_H_
#define _Gyro6050_H_
#include "variables.h"
#include <MPU6050_light.h>
#include "innit.h"
#define DEBUG

void Gyro6050() {
   mpu.update();
  if ((millis() - timer) > 10) { // print data every 10ms
    roll = mpu.getAngleX();

#ifdef DEBUG
    Serial.print("X : ");
    Serial.println(roll);
#endif

    timer = millis();
  }
  if (abs(roll) >= 85) {
    counter++;
    if (counter >= 10) {
      flag = 1;
      counter = 0;
    }
  }
  if (flag == 1) {
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
    flag = 0;
  }
}

#endif
