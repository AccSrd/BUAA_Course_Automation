using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class unitylhtIK : MonoBehaviour
{
    // Start is called before the first frame update

    public Camera cam;
    private Animator ani;

    void Start()
    {
        ani = this.GetComponent<Animator>();   
    }

    // Update is called once per frame
    void Update()
    {    
    }

    void OnAnimatorIK()
    {
        ani.SetLookAtWeight(0.7f, 0.3f, 1, 1);
        ani.SetLookAtPosition(cam.transform.position);
    }
}
