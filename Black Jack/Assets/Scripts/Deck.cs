using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Deck : MonoBehaviour
{
    private List<Card> deck;

    public Deck()
    {
        deck = new List<Card>();
    }

    // Start is called before the first frame update
    void Start()
    {
        SetDeck();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void SetDeck()
    {
        deck.Clear();
        
        for (int i = 0; i < 13; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                Card newCard = new Card(j, i);
                deck.Add(newCard);
            }
        }

        Shuffle<Card>(deck);
    }

    private void Shuffle<T>(IList<T> ts) {
        var count = ts.Count;
        var last = count - 1;
        for (var i = 0; i < last; ++i) {
            var r = UnityEngine.Random.Range(i, count);
            var tmp = ts[i];
            ts[i] = ts[r];
            ts[r] = tmp;
        }
    }

    public Card Pop()
    {
        Card topCard = new Card(0, 0);
        return topCard;
    }


}
