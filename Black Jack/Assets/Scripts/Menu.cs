using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Menu : MonoBehaviour
{
    [SerializeField] private GameObject pauseScreen;
    [SerializeField] private GameObject continueButton;
    public bool isPaused;

    void Start()
    {

        //Time.timeScale = 1f;
        //isPaused = false;
        //Resume();
        if (MoneyStats.LetterPlayed == false)
        {
            continueButton.GetComponent<Image>().color = Color.gray;
            continueButton.GetComponent<Button>().interactable = false;
            //continueButton.SetActive(false);
        }
    }

    void Update()
    {
        // if (Input.GetKeyDown(KeyCode.Escape)) {
        //     if (!isPaused) {
        //         Debug.Log("pressed");
        //         Pause();
        //         isPaused = true;
        //     } else {
        //         Resume();
        //         isPaused = false;
        //     }
        // } 
    }

    public void StartGame()
    {
        SceneManager.LoadScene("LetterScene");
    }

    public void NextLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
        MoneyStats.LetterPlayed = true;
    }

    public void StartOver()
    {
        MoneyStats.HouseWallet = 200;
        MoneyStats.PersonalWallet = 0;
        MoneyStats.LetterPlayed = false;
        MoneyStats.Day = 1;
        SceneManager.LoadScene("root");
    }

    public void Credits()
    {
        SceneManager.LoadScene("Credits");
    }

    public void Pause()
    {
        pauseScreen.SetActive(true);
        Time.timeScale = 0f;
    }

    public void Resume()
    {
        pauseScreen.SetActive(false);
        Time.timeScale = 1f;
    }

    public void ReturnToMenu()
    {
        SceneManager.LoadScene("Menu");
    }

    public void ExitGame()
    {
        Application.Quit();
    }
}