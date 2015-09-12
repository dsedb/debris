using UnityEngine;
using System.Collections;

public class SimpleMovement : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		float input_v = Input.GetAxis ("Vertical");
		float input_h = Input.GetAxis ("Horizontal");
		if (input_v != 0) {
			transform.rotation *= Quaternion.Euler (-input_v, 0, 0);
		}
		if (input_h != 0) {
			transform.rotation *= Quaternion.Euler (0, 0, input_h);
		}
		transform.position += transform.rotation * Vector3.forward * Time.deltaTime * 20.0f;
	}
}
