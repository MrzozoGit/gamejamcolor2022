using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerCollectMarbles : MonoBehaviour
{
    [SerializeField] public int marbles = 50;
    [SerializeField] public int totalMarbles = 50;

    [SerializeField] public Font GUI_font;
    [SerializeField] public int GUI_fontSize = 20;
    [SerializeField] public int GUI_textX = 20;
    [SerializeField] public int GUI_textY = 25;
    [SerializeField] public int GUI_textWidth = 200;
    [SerializeField] public int GUI_textHeight = 40;

    [SerializeField] public Texture GUI_icon;
    [SerializeField] public int GUI_iconX = 100;
    [SerializeField] public int GUI_iconY = 20;
    [SerializeField] public int GUI_iconWidth = 100;
    [SerializeField] public int GUI_iconHeight = 100;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnGUI()
    {
        GUI.skin.label.font = GUI_font;
        GUI.skin.label.fontSize = GUI_fontSize;
        GUI.Label(new Rect(GUI_iconX, GUI_iconY, GUI_iconWidth, GUI_iconHeight), GUI_icon);
        GUI.Label(new Rect(GUI_textX, GUI_textY, GUI_textWidth, GUI_textHeight), marbles + "/" + totalMarbles);
    }
}
