using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class InputHandler : MonoBehaviour
{
    public Camera _mainCamera;
    public int whomHit; // 0 - gangster; 1 - rich; 2 - flirt
    public bool clicked;

    private void Awake()
    {
 
    }

    // Start is called before the first frame update
    void Start()
    {
        whomHit = 0;
        clicked = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Vector3 mousePos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            Vector2 mousePos2D = new Vector2(mousePos.x, mousePos.y);

            RaycastHit2D hit = Physics2D.Raycast(mousePos2D, Vector2.zero);

            if (hit.collider != null)
            {
                if (hit.collider.gameObject.name.Equals("Gangster"))
                {
                    whomHit = 0;
                }
                else if (hit.collider.gameObject.name.Equals("Rich"))
                {
                    whomHit = 1;
                }
                else if (hit.collider.gameObject.name.Equals("Flirt"))
                {
                    whomHit = 2;
                }
                else
                {
                    whomHit = -1;
                }

                clicked = true;
            }
        }
    }

    public void setClicked(bool state)
    {
        clicked = state;
    }

}
