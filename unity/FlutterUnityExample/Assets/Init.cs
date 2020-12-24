using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Init : MonoBehaviour
{
    public GameObject models = null;

    void Start()
    {
        Application.targetFrameRate = 30;
        Screen.SetResolution(1280, 720, false);

        models = GameObject.Find("ModelS_Scene");
        models.SetActive(false);
    }
    
    public void loadModel(string data) {
        FlutterUnityPlugin.Message message = FlutterUnityPlugin.Messages.Receive(data);

        switch (message.data)
        {
            case "models":
                models.SetActive(true);
                break;
            default: break;
        }
    }
}
