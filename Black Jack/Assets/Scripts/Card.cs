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

    public GameObject CreateObject()
    {
        GameObject obj = new GameObject(this.suit.ToString() + "_" + this.value.ToString());
        
        SpriteRenderer spriteRenderer = gameObject.AddComponent<SpriteRenderer> ();
        Sprite sprite = Resources.Load<Sprite> ("Sprites/Cards" + obj.name + ".png");
        spriteRenderer.sprite = sprite;

        return obj;
    }
}
