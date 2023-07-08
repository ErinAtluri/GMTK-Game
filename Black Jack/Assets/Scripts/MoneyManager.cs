using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class MoneyManager : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI houseMoneyText;
    [SerializeField] private TextMeshProUGUI myMoneyText;
    // Start is called before the first frame update
    void Start()
    {
        houseMoneyText.text = "House Money: " + MoneyStats.HouseWallet;
        myMoneyText.text = "My Money: " + MoneyStats.PersonalWallet;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
