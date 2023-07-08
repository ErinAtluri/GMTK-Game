using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class Gambler : MonoBehaviour 
{
    private List<Card> hand = new List<Card>();

    void OnMouseDown()
    {

    }

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }

    public void DealCard(Card card)
    {
        hand.Add(card);
    }

    public bool HandFull()
    {
        if (hand.Count == 2)
        {
            return true;
        }

        return false;
    }

    public int GetScore()
    {
        return 0;
    }
}
