using System.Collections;
using System.Collections.Generic;
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

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
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
}
