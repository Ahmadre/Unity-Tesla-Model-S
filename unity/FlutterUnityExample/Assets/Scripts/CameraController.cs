using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public void SetBackgroundColor(string data)
    {
        FlutterUnityPlugin.Message message = FlutterUnityPlugin.Messages.Receive(data);

        // Flutter --> "128,128,128"
        
        var part = message.data.Split(","[0]);
        float red = float.Parse(part[0]) / 255;
        float green = float.Parse(part[1]) / 255;
        float blue = float.Parse(part[2]) / 255;

        Color color = new Color(red, green, blue);
        
        Camera cam = gameObject.GetComponent<Camera>();
        cam.clearFlags = CameraClearFlags.SolidColor;
        cam.backgroundColor = color;
    }
}
