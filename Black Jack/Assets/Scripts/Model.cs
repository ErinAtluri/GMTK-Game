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
    [SerializeField] private Gangster gangster;
    [SerializeField] private Rich rich;
    [SerializeField] private Flirt flirt;
    [SerializeField] private InputHandler inputHandler;

    [SerializeField] private GameObject cardPrefab;

    // Start is called before the first frame update
    void Start()
    {
        deck.SetDeck();
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

    private void CreateCard(Card card)
    {
        Instantiate(cardPrefab, new Vector3(0, 0, 0), Quaternion.identity);
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
                    Card card = deck.Pop();
                    gangster.DealCard(card);
                    CreateCard(card);
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

            foreach (Card card in gangster.GetHand())
            {
                // pass
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
