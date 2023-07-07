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
        }
    }
}
