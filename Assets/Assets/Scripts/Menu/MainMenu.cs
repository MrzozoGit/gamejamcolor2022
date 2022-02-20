using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
    [SerializeField] public Animator animator;
    [SerializeField] public LevelChanger levelChanger;
    [SerializeField] public int levelToLoad = 1;

    public void playGame()
    {
        levelChanger.FadeToLevel(levelToLoad);
    }

    public void quitGame()
    {
        Application.Quit();
    }
}
