using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Driving : MonoBehaviour
{
    public void SetCarSpeed(string data)
    {
        /// Flutter --> "2"
        
        FlutterUnityPlugin.Message message = FlutterUnityPlugin.Messages.Receive(data);

        int speed = int.Parse(message.data);

        GameObject DriverFrontWheel = GameObject.Find("wheel");
        GameObject PassengerFrontWheel = GameObject.Find("wheel.001");
        GameObject DriverRearWheel = GameObject.Find("wheel.002");
        GameObject PassengerRearWheel = GameObject.Find("wheel.003");

        DriverFrontWheel.GetComponent<Animator>().SetInteger("speed", speed);
        PassengerFrontWheel.GetComponent<Animator>().SetInteger("speed", speed);
        DriverRearWheel.GetComponent<Animator>().SetInteger("speed", speed);
        PassengerRearWheel.GetComponent<Animator>().SetInteger("speed", speed);
    }
}
