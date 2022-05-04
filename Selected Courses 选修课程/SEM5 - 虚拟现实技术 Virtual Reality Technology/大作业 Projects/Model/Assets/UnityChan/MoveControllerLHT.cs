using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveControllerLHT : MonoBehaviour
{
    // Start is called before the first frame update
    public Camera cam;
    private Vector3 hitPoint;
    private Vector3 look_rotation;
    public GameObject girl;
    private Animator ani;
    public float speed = 30;
    void Start()
    {
        cam = this.GetComponent<Camera>();
        ani = girl.GetComponent<Animator>();
    }
    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = cam.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if(Physics.Raycast(ray,out hit))
            {
                if (hit.collider.gameObject.name == "Plane")
                {
                    hitPoint = new Vector3(hit.point.x, girl.transform.position.y, hit.point.z);
                    look_rotation = hitPoint - girl.transform.position;
                    Debug.Log(hitPoint);
                }
            }
        }
        girl.transform.position = Vector3.MoveTowards(girl.transform.position, hitPoint, Time.deltaTime * speed);
        girl.transform.rotation = Quaternion.Lerp(girl.transform.rotation, Quaternion.LookRotation(look_rotation), Time.deltaTime * 10f);

        if (Vector3.SqrMagnitude(hitPoint - girl.transform.position) < 0.01f)
        {
            ani.SetBool("IsWalk", false);
        }
        else
        {
            ani.SetBool("IsWalk", true);           
        }
    }
}
