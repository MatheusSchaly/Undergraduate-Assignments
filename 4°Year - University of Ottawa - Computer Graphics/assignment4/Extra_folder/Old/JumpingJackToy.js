function init() {
    // Check if WebGL is available see Three/examples
    if (THREE.WEBGL.isWebGLAvailable() === false) {
        // if not print error on console and exit
        document.body.appendChild(WEBGL.getWebGLErrorMessage());
    }
    // add our rendering surface and initialize the renderer
    var container = document.createElement('div');
    document.body.appendChild(container);
    renderer = new THREE.WebGLRenderer();
    // set some state - here just clear color
    renderer.setClearColor(new THREE.Color(0x333333));
    renderer.setSize(window.innerWidth, window.innerHeight);
    container.appendChild(renderer.domElement);
	
    // All drawing will be organized in a scene graph
    var scene = new THREE.Scene();

    // jumpingJack system group
    var jumpingJack = new THREE.Group();
    scene.add(jumpingJack)
    // torso is a child
    var faceMaterial = new THREE.MeshBasicMaterial({ color: 'blue' });
    var cylinderGeometry = new THREE.CylinderGeometry(8, 8, 25);
    var torso = new THREE.Mesh(cylinderGeometry, faceMaterial);
    // position the torso - center
    torso.position.set(0, 0, 0);
    // add the torso to the scene
    jumpingJack.add(torso);
	
	// Adding head to the torso
	var headGroup = new THREE.Group();
	headGroup.position.set(0, 21.5, 2);
	jumpingJack.add(headGroup);
	
	var faceMaterialHead = new THREE.MeshBasicMaterial({ color: 'pink' });
	var headGeometry = new THREE.SphereGeometry(7);
	var head = new THREE.Mesh(headGeometry, faceMaterialHead);
	headGroup.add(head);
	
	// Adding right eye to the head
	var faceMaterialRightEye = new THREE.MeshBasicMaterial({ color: 'white' });
	var rightEyeGeometry = new THREE.SphereGeometry(1.3);
	var rightEye = new THREE.Mesh(rightEyeGeometry, faceMaterialRightEye);
	rightEye.position.set(-2.3, 0, 7);
	headGroup.add(rightEye);
	
	// Adding left eye to the head
	var faceMaterialLeftEye = new THREE.MeshBasicMaterial({ color: 'white' });
	var leftEyeGeometry = new THREE.SphereGeometry(1.3);
	var leftEye = new THREE.Mesh(leftEyeGeometry, faceMaterialLeftEye);
	leftEye.position.set(2.3, 0, 7);
	headGroup.add(leftEye);
	
	// Adding head rotation
	var headRotGroup = new THREE.Group();
    jumpingJack.add(headRotGroup);
	headRotGroup.add(headGroup);
	
	// Adding nose to the head
	var faceMaterialNose = new THREE.MeshBasicMaterial({ color: 'red' });
	var noseGeometry = new THREE.SphereGeometry(1.0);
	var nose = new THREE.Mesh(noseGeometry, faceMaterialNose);
	nose.position.set(0, -1.5, 7);
	headGroup.add(nose);
	
	// Adding string to the torso
	var stringGroup = new THREE.Group();
	stringGroup.position.set(0, -20, 1)
	jumpingJack.add(stringGroup)
	
	var faceMaterialString = new THREE.MeshBasicMaterial({ color: 'brown' });
	var stringGeometry = new THREE.CylinderGeometry(0.5, 0.5, 40);
	var string = new THREE.Mesh(stringGeometry, faceMaterialString);
	stringGroup.add(string);
	
	// Adding marble to the string
	var faceMaterialMarble = new THREE.MeshBasicMaterial({ color: 'red' });
	var marbleGeometry = new THREE.SphereGeometry(2);
	var marble = new THREE.Mesh(marbleGeometry, faceMaterialMarble);
	marble.position.set(0, -15, 1);
	stringGroup.add(marble);
	
	// Adding neck to the torso
	var faceMaterialNeck = new THREE.MeshBasicMaterial({ color: 'blue' });
	var neckGeometry = new THREE.CylinderGeometry(3, 3, 2);
	var neck = new THREE.Mesh(neckGeometry, faceMaterialNeck);
	neck.position.set(0, 14, 1);
	jumpingJack.add(neck);
	
	// Adding neck to the torso
	var faceMaterialNeck = new THREE.MeshBasicMaterial({ color: 'blue' });
	var neckGeometry = new THREE.CylinderGeometry(3, 3, 2);
	var neck = new THREE.Mesh(neckGeometry, faceMaterialNeck);
	neck.position.set(0, 14, 1);
	jumpingJack.add(neck);
	
	// Adding right arm joint
	var rightArmJointGroup = new THREE.Group();
	rightArmJointGroup.position.set(5, 9, 6);
	jumpingJack.add(rightArmJointGroup);
	
	var faceMaterialRightArmJoint = new THREE.MeshBasicMaterial({ color: 'yellow' });
    var rightArmJointGeometry = new THREE.SphereGeometry(1.0);
	var rightArmJoint = new THREE.Mesh(rightArmJointGeometry, faceMaterialRightArmJoint)
    rightArmJointGroup.add(rightArmJoint);
	
	// Adding right arm to the right arm joint
    var faceMaterialRightArm = new THREE.MeshBasicMaterial({ color: 'red' });
    var rightArmGeometry = new THREE.CylinderGeometry(3, 3, 13);
	// Rotates 72 degrees clockwise around z-axis
	rightArmGeometry.rotateZ(-Math.PI * 0.4) 
	var rightArm = new THREE.Mesh(rightArmGeometry, faceMaterialRightArm);
	rightArm.position.set(8, 2, -6);
    rightArmJointGroup.add(rightArm);
	
	// Adding right hand to the right arm joint
	var faceMaterialRightHand = new THREE.MeshBasicMaterial({ color: 'pink' })
	var rightHandGeometry = new THREE.SphereGeometry(4);
	var rightHand = new THREE.Mesh(rightHandGeometry, faceMaterialRightHand);
	rightHand.position.set(15, 4.5, -6);
	rightArmJointGroup.add(rightHand);
	
	// Adding left arm joint
	var leftArmJointGroup = new THREE.Group();
	leftArmJointGroup.position.set(-5, 9, 6);
	jumpingJack.add(leftArmJointGroup);
	
	var faceMaterialLeftArmJoint = new THREE.MeshBasicMaterial({ color: 'yellow' });
    var leftArmJointGeometry = new THREE.SphereGeometry(1.0);
	var leftArmJoint = new THREE.Mesh(leftArmJointGeometry, faceMaterialLeftArmJoint)
    leftArmJointGroup.add(leftArmJoint);
	
	// Adding left arm to the left arm joint
    var faceMaterialLeftArm = new THREE.MeshBasicMaterial({ color: 'red' });
    var leftArmGeometry = new THREE.CylinderGeometry(3, 3, 13);
	// Rotates 72 degrees anticlockwise around z-axis
	leftArmGeometry.rotateZ(Math.PI * 0.4);
	var leftArm = new THREE.Mesh(leftArmGeometry, faceMaterialLeftArm);
	leftArm.position.set(-8, 2, -6);
    leftArmJointGroup.add(leftArm);
	
	// Adding left hand to the left arm joint
	var faceMaterialLeftHand = new THREE.MeshBasicMaterial({ color: 'pink' })
	var leftHandGeometry = new THREE.SphereGeometry(4);
	var leftHand = new THREE.Mesh(leftHandGeometry, faceMaterialLeftHand);
	leftHand.position.set(-15, 4.5, -6);
	leftArmJointGroup.add(leftHand);
    
	// Adding upper right leg joint to the torso
	var upperRightLegJointGroup = new THREE.Group();
	upperRightLegJointGroup.position.set(5, -9, 6);
	jumpingJack.add(upperRightLegJointGroup);
	
	var faceMaterialUpperRightLegJoint = new THREE.MeshBasicMaterial({ color: 'yellow' });
	var upperRightLegJointGeometry = new THREE.SphereGeometry(1.0);
	var upperRightLegJoint = new THREE.Mesh(upperRightLegJointGeometry, faceMaterialUpperRightLegJoint);
	upperRightLegJointGroup.add(upperRightLegJoint);
	
	// Adding upper right leg to the right leg joint
	var faceMaterialUpperRightLeg = new THREE.MeshBasicMaterial({ color: 'green' });
	var upperRightLegGeometry = new THREE.CylinderGeometry(4, 4, 15);
	// Rotates 126 degrees clockwise around z-axis
	upperRightLegGeometry.rotateZ(-Math.PI * 0.7);
	var upperRightLeg = new THREE.Mesh(upperRightLegGeometry, faceMaterialUpperRightLeg);
	upperRightLeg.position.set(7, -5.5, -6);
	upperRightLegJointGroup.add(upperRightLeg);
	
	// Adding lower right leg to the right leg joint
	var faceMaterialLowerRightLeg = new THREE.MeshBasicMaterial({ color: 'green' });
	var lowerRightLegGeometry = new THREE.CylinderGeometry(3.5, 3.5, 14);
	// Rotates 9 degrees clockwise aorund z-axis
	lowerRightLegGeometry.rotateZ(-Math.PI * 0.05);
	var lowerRightLeg = new THREE.Mesh(lowerRightLegGeometry, faceMaterialLowerRightLeg);
	lowerRightLeg.position.set(12, -14, -6);
	upperRightLegJointGroup.add(lowerRightLeg);
	
	// Adding right foot to the right leg joint
	var faceMaterialRightFoot = new THREE.MeshBasicMaterial({ color: 'brown' });
	var rightFootGeometry = new THREE.CylinderGeometry(2, 3, 10);
	// Rotates 108 degrees clockwise aorund z-axis
	rightFootGeometry.rotateZ(-Math.PI * 0.6);
	var rightFoot = new THREE.Mesh(rightFootGeometry, faceMaterialRightFoot);
	rightFoot.position.set(13, -24, -6);
	upperRightLegJointGroup.add(rightFoot);
	
	// Adding upper left leg joint to the torso
	var upperLeftLegJointGroup = new THREE.Group();
	upperLeftLegJointGroup.position.set(-5, -9, 6);
	jumpingJack.add(upperLeftLegJointGroup);
	
	var faceMaterialUpperLeftLegJoint = new THREE.MeshBasicMaterial({ color: 'yellow' });
	var upperLeftLegJointGeometry = new THREE.SphereGeometry(1.0);
	var upperLeftLegJoint = new THREE.Mesh(upperLeftLegJointGeometry, faceMaterialUpperRightLegJoint);
	upperLeftLegJointGroup.add(upperLeftLegJoint);
	
	// Adding upper left leg to the left leg joint
	var faceMaterialUpperLeftLeg = new THREE.MeshBasicMaterial({ color: 'green' });
	var upperLeftLegGeometry = new THREE.CylinderGeometry(4, 4, 15);
	// Rotates 54 degrees clockwise around z-axis
	upperLeftLegGeometry.rotateZ(-Math.PI * 0.3);
	var upperLeftLeg = new THREE.Mesh(upperLeftLegGeometry, faceMaterialUpperLeftLeg)
	upperLeftLeg.position.set(-7, -5.5, -6);
	upperLeftLegJointGroup.add(upperLeftLeg);
	
	// Adding lower left leg to the left leg joint
	var faceMaterialLowerLeftLeg = new THREE.MeshBasicMaterial({ color: 'green' });
	var lowerLeftLegGeometry = new THREE.CylinderGeometry(3.5, 3.5, 14);
	// Rotates 9 degrees anticlockwise aorund z-axis
	lowerLeftLegGeometry.rotateZ(Math.PI * 0.05);
	var lowerLeftLeg = new THREE.Mesh(lowerLeftLegGeometry, faceMaterialLowerRightLeg);
	lowerLeftLeg.position.set(-12, -14, -6);
	upperLeftLegJointGroup.add(lowerLeftLeg);
	
	// Adding left foot to the upper left leg
	var faceMaterialLeftFoot = new THREE.MeshBasicMaterial({ color: 'brown' });
	var leftFootGeometry = new THREE.CylinderGeometry(2, 3, 10);
	// Rotates 108 degrees anticlockwise aorund z-axis
	leftFootGeometry.rotateZ(Math.PI * 0.6);
	var leftFoot = new THREE.Mesh(leftFootGeometry, faceMaterialLeftFoot);
	leftFoot.position.set(-13, -24, -6);
	upperLeftLegJointGroup.add(leftFoot);
	
	// Adding upper button to the torso
	var faceMaterialUpperButton = new THREE.MeshBasicMaterial({ color: 'red' });
	var upperButtonGeometry = new THREE.SphereGeometry(1);
	var upperButton = new THREE.Mesh(upperButtonGeometry, faceMaterialUpperButton);
	upperButton.position.set(0, 4, 9);
	jumpingJack.add(upperButton);
	
	// Adding lower button to the torso
	var faceMaterialLowerButton = new THREE.MeshBasicMaterial({ color: 'red' });
	var lowerButtonGeometry = new THREE.SphereGeometry(1);
	var lowerButton = new THREE.Mesh(lowerButtonGeometry, faceMaterialLowerButton);
	lowerButton.position.set(0, -4, 9);
	jumpingJack.add(lowerButton);

    // need a camera to look at things
    // calcaulate aspectRatio
    var aspectRatio = window.innerWidth / window.innerHeight;
    var width = 20;
    // Camera needs to be global
    camera = new THREE.PerspectiveCamera(50, aspectRatio, 1, 1000);
    // position the camera back and point to the center of the scene
    camera.position.z = 100
    camera.lookAt(scene.position);

    // render the scene
    renderer.render(scene, camera);

    //declared once at the top of your code
    var camera_axis = new THREE.Vector3(-30,30,30).normalize(); // viewing axis
    
	var headYControl = new function () {
		this.headYRotation = 0;
    };

	var headXControl = new function () {
		this.headXRotation = 0;
    };
	
	var cameraXControl = new function () {
		this.cameraXRotation = 0;
	}
	
	var cameraYControl = new function () {
		this.cameraYRotation = 0;
	}
	
	var stringSpeedControl = new function () {
		this.oneToTurnItOn = 1;
	}

    var gui = new dat.GUI();
	var direction = -0.05
	gui.add(headYControl, 'headYRotation', -20, 20)
	gui.add(headXControl, 'headXRotation', -6, 10)
	gui.add(cameraXControl, 'cameraXRotation', -Math.PI, Math.PI)
	gui.add(cameraYControl, 'cameraYRotation', -Math.PI/2, Math.PI/2)
	gui.add(stringSpeedControl, 'oneToTurnItOn', 0, 1)
	render();
	THREE.c
	
    function render() {
		// render using requestAnimationFrame - register function
		requestAnimationFrame(render);
		headRotGroup.rotation.y = 0.1 * headYControl.headYRotation;
		headRotGroup.rotation.x = 0.1 * headXControl.headXRotation;
		// string is pulled down and up
		if (stringGroup.position.y > -20) {
			direction = -0.07
		} else if (stringGroup.position.y < -25) {
			direction = +0.07
		}
		if (stringSpeedControl.oneToTurnItOn == 1) {
			stringGroup.position.y += direction * stringSpeedControl.oneToTurnItOn
			rightArmJointGroup.rotation.z -= direction * stringSpeedControl.oneToTurnItOn * 0.1
			leftArmJointGroup.rotation.z += direction * stringSpeedControl.oneToTurnItOn * 0.1
			upperLeftLegJointGroup.rotation.z += direction * stringSpeedControl.oneToTurnItOn * 0.1
			upperRightLegJointGroup.rotation.z -= direction * stringSpeedControl.oneToTurnItOn * 0.1
		}
		
		renderer.render(scene, camera);
		// move camera
		camera.position.x = Math.sin(cameraXControl.cameraXRotation) * 200
		camera.position.z = Math.cos(cameraXControl.cameraXRotation) * 200
		camera.position.y = Math.sin(cameraYControl.cameraYRotation) * 200
		//camera.position.z = Math.cos(cameraYControl.cameraYRotation) * 200
		camera.lookAt(scene.position); // Looking at the at position
    }

}

function onResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    // If we use a canvas then we also have to worry of resizing it
    renderer.setSize(window.innerWidth, window.innerHeight);
}

window.onload = init;

// register our resize event function
window.addEventListener('resize', onResize, true);







