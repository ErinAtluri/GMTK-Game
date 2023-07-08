using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class Gambler : MonoBehaviour 
{
    Camera m_Camera;
    public Card[] hand = new Card[2];
    public int totalScore;

    void OnMouseDown()
    {

    }

    // Start is called before the first frame update
    void Start()
    {
        m_Camera = Camera.main;
    }

    // Update is called once per frame
    void Update()
    {
        Mouse mouse = Mouse.current;
        if (mouse.leftButton.wasPressedThisFrame)
        {
            Vector3 mousePosition = mouse.position.ReadValue();
            Ray ray = m_Camera.ScreenPointToRay(mousePosition);
            if (Physics.Raycast(ray, out RaycastHit hit))
            {
                // Use the hit variable to determine what was clicked on.
            }
        }
    }
}
