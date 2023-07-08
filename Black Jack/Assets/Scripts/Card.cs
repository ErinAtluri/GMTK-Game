using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Card : MonoBehaviour 
{
    public int suit { get; set; }
    public int value { get; set; }

    public Card(int suit, int value)
    {
        this.suit = suit;
        this.value = value;
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public Sprite CreateSprite()
    {
        Sprite sprite = Resources.Load<Sprite> ("Sprites/Cards/2_1.png"); // ("Sprites/Cards" + obj.name + ".png");

        return sprite;
    }

    public void Info()
    {
        print(suit);
        print(value);
    }
}
