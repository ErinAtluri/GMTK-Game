using System.Collections;
using System.Collections.Generic;
using System.Xml.Serialization;
using UnityEngine;

public class Model : MonoBehaviour
{
    enum State
    {
        Deal,
        Swap,
        Bets,
        Hit,
        Special,
        Payout,
        Flatscreen,
    }

    private State state = State.Deal;
    private Deck deck = new Deck();
    [SerializeField] private Flirt flirt;
    [SerializeField] private Gangster gangster;
    [SerializeField] private Rich rich;
    [SerializeField] private InputHandler inputHandler;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (inputHandler.clicked)
        {
            inputHandler.setClicked(false);
            Clicked();
        }
        
        switch (state)
        {
        case State.Deal:
            break;
        case State.Swap:
            break;
        case State.Bets:
            break;
        case State.Hit:
            break;
        case State.Special:
            break;
        case State.Payout:
            break;
        case State.Flatscreen:
            break;
        }
    }

    private void Clicked()
    {
        switch (state)
        {
        case State.Deal:
            switch(inputHandler.whomHit)
            {
            case -1:
                break;
            case 0:
                if (!gangster.HandFull())
                {
                    gangster.DealCard(deck.Pop());
                    Debug.Log("dealt to gangster");
                }

                break;
            case 1:
                if (!rich.HandFull())
                {
                    rich.DealCard(deck.Pop());
                    Debug.Log("dealt to rich");
                }

                break;
            case 2:
                if (!flirt.HandFull())
                {
                    flirt.DealCard(deck.Pop());
                    Debug.Log("dealt to flirt");
                }
                
                break;
            }
            break;
        case State.Swap:
            break;
        case State.Bets:
            break;
        case State.Hit:
            break;
        case State.Special:
            break;
        case State.Payout:
            break;
        case State.Flatscreen:
            break;
        }
    }
}
