var origin = new THREE.Vector3( 0, 0, 0 );
var original_eye = new THREE.Vector3( -60, 60, 100);
var object;
scene = new THREE.Scene();

function main() {
	
	var mtlLoader = new THREE.MTLLoader();
	mtlLoader.setPath('./models/');
	// Works for tiger, triceratops1Text and dino50K
	mtlLoader.load('tiger.mtl', function (materials) {
		materials.preload();
		var objLoader = new THREE.OBJLoader();
		objLoader.setMaterials(materials);
		objLoader.setPath('./models/');
		objLoader.load('tiger.obj', function (object) {
			scene.add(object);
			object.position.set(origin.x, origin.y, origin.z)
			object.scale.set( 0.05, 0.05, 0.05);
		});
	});
		
	var SCREEN_WIDTH = window.innerWidth;
	var SCREEN_HEIGHT = window.innerHeight;
	var aspect = SCREEN_WIDTH / SCREEN_HEIGHT;

	var initialZSpeed = 0.02;
	var zSpeed = 0;

	var container
	var camera, renderer;
	var cameraOrtho;
	var cameraOrthoHelper;
	var d_left_line = 0, d_right_line = 0; 
	var d_top_line = 0, d_bottom_line = 0;
	var d_near_line = 0, d_far_line = 0;
	var d_eye_x = 0, d_eye_y = 0, d_eye_z = 0;
	var frustum_var = 500;
	var far_view_ortho = 400;

	container = document.createElement( 'div' );
	document.body.appendChild( container );

	camera = new THREE.PerspectiveCamera(50, aspect, 1, 100000);
	camera.position.x = original_eye.x;
	camera.position.y = original_eye.y;
	camera.position.z = original_eye.z;
	
	cameraOrtho = new THREE.OrthographicCamera( frustum_var * aspect / - 2, frustum_var * aspect / 2, frustum_var * aspect / 2 * 0.2, frustum_var * aspect / - 2 * 0.2, 0, far_view_ortho );
	cameraOrthoHelper = new THREE.CameraHelper( cameraOrtho );
	cameraOrtho.position.y = 0;
	cameraOrtho.position.x = 0;
	cameraOrtho.position.z = 200;
	
	scene.add( cameraOrthoHelper );
	
	// Pickup Truck
    var pickupTruck = new THREE.Group();
    scene.add(pickupTruck)
	var mainMaterial = new THREE.MeshPhongMaterial({ color: 'lightblue' });
    var bodyMaterial = new THREE.MeshPhongMaterial({ color: 'blue' });
	var openMaterial = new THREE.MeshPhongMaterial({ color: 'green' });
	var windowMaterial = new THREE.MeshPhongMaterial({ color: 'lightgrey' });
	var axisMaterial = new THREE.MeshPhongMaterial({ color: 'red'  });
	var wheelMaterial = new THREE.MeshPhongMaterial({ color: 'brown'  });
	
	
	// Main body
    var mainBodyGeometry = new THREE.BoxGeometry(20, 2, 60);
    var mainBody = new THREE.Mesh(mainBodyGeometry, mainMaterial);
    mainBody.position.set(0, 0, 0);
    pickupTruck.add(mainBody);
	
	
	// Right rear
	var rightRearGeometry = new THREE.BoxGeometry(1, 10, 30);
    var rightRear = new THREE.Mesh(rightRearGeometry, bodyMaterial);
    rightRear.position.set(-9.5, 5, -15);
    pickupTruck.add(rightRear);
	
	
	// Left rear
	var leftRearGeometry = new THREE.BoxGeometry(1, 10, 30);
    var leftRear = new THREE.Mesh(leftRearGeometry, bodyMaterial);
    leftRear.position.set(9.5, 5, -15);
    pickupTruck.add(leftRear);
	
	
	// Right door group
	var rightDoorGroup = new THREE.Group();
	rightDoorGroup.position.set(-10, 5, 15);
	pickupTruck.add(rightDoorGroup);
	
	// Right door axis
	var rightDoorAxisGeometry = new THREE.CylinderGeometry(0.5, 0.5, 10);
    var rightDoorAxis = new THREE.Mesh(rightDoorAxisGeometry, axisMaterial);
    rightDoorAxis.position.set(0, 0, 0);
    rightDoorGroup.add(rightDoorAxis);
	
	// Right door
	var rightDoorGeometry = new THREE.BoxGeometry(0.5, 10, 12);
    var rightDoor = new THREE.Mesh(rightDoorGeometry, openMaterial);
    rightDoor.position.set(0, 0, -5);
    rightDoorGroup.add(rightDoor);
	
	// Right window
	var rightWindowGeometry = new THREE.BoxGeometry(0.2, 9, 9);
    var rightWindow = new THREE.Mesh(rightWindowGeometry, windowMaterial);
    rightWindow.position.set(0, 9.5, -6.5);
    rightDoorGroup.add(rightWindow);
	
	
	// Left door group
	var leftDoorGroup = new THREE.Group();
	leftDoorGroup.position.set(10, 5, 15);
	pickupTruck.add(leftDoorGroup);
	
	// Left door axis
	var leftDoorAxisGeometry = new THREE.CylinderGeometry(0.5, 0.5, 10);
    var leftDoorAxis = new THREE.Mesh(leftDoorAxisGeometry, axisMaterial);
    leftDoorAxis.position.set(0, 0, 0);
    leftDoorGroup.add(leftDoorAxis);
	
	// Left door
	var leftDoorGeometry = new THREE.BoxGeometry(0.5, 10, 12);
    var leftDoor = new THREE.Mesh(leftDoorGeometry, openMaterial);
    leftDoor.position.set(0, 0, -5);
    leftDoorGroup.add(leftDoor);
	
	// Left window
	var leftWindowGeometry = new THREE.BoxGeometry(0.2, 9, 9);
    var leftWindow = new THREE.Mesh(leftWindowGeometry, windowMaterial);
    leftWindow.position.set(0, 9.5, -6.5);
    leftDoorGroup.add(leftWindow);
	
	
	// Middle right
	var rightMiddleGeometry = new THREE.BoxGeometry(1, 19, 4);
    var rightMiddle = new THREE.Mesh(rightMiddleGeometry, bodyMaterial);
    rightMiddle.position.set(-9.5, 11, 2);
    pickupTruck.add(rightMiddle);
	
	
	// Middle left
	var leftMiddleGeometry = new THREE.BoxGeometry(1, 19, 4);
    var leftMiddle = new THREE.Mesh(leftMiddleGeometry, bodyMaterial);
    leftMiddle.position.set(9.5, 11, 2);
    pickupTruck.add(leftMiddle);
	
	
	// Middle
	var middleGeometry = new THREE.BoxGeometry(20, 10, 1);
    var middle = new THREE.Mesh(middleGeometry, bodyMaterial);
    middle.position.set(0, 5, 2);
    pickupTruck.add(middle);
	
	
	// Back group
	var backGroup = new THREE.Group();
	backGroup.position.set(0, 0, -30);
	pickupTruck.add(backGroup);

	// Back axis
	var backAxisGeometry = new THREE.BoxGeometry(20, 0.5, 0.5);
    var backAxis = new THREE.Mesh(backAxisGeometry, axisMaterial);
    backAxis.position.set(0, 0, 0);
    backGroup.add(backAxis);
	
	// Back
	var backGeometry = new THREE.BoxGeometry(20, 10, 0.5);
    var back = new THREE.Mesh(backGeometry, openMaterial);
    back.position.set(0, 5, 0);
    backGroup.add(back);
	
	
	// Front
	var frontGeometry = new THREE.BoxGeometry(20, 7, 0.5);
    var front = new THREE.Mesh(frontGeometry, bodyMaterial);
    front.position.set(0, 3, 30);
    pickupTruck.add(front);
	
	
	// Hood group
	var hoodGroup = new THREE.Group();
	hoodGroup.position.set(0, 10, 17);
	pickupTruck.add(hoodGroup);
	
	// Hood axis
	var hoodAxisGeometry = new THREE.BoxGeometry(20, 0.5, 0.5);
    var hoodAxis = new THREE.Mesh(hoodAxisGeometry, axisMaterial);
    hoodAxis.position.set(0, 0, 0);
    hoodGroup.add(hoodAxis);
	
	// Hood
	var hoodGeometry = new THREE.BoxGeometry(20, 13, 0.5);
    var back = new THREE.Mesh(hoodGeometry, openMaterial);
	back.rotation.x = 1.8
    back.position.set(0, -1.5, 6.5);
    hoodGroup.add(back);
	
	
	// Door top right
	var doorTopRightGeometry = new THREE.BoxGeometry(1, 2, 10);
    var doorTopRight = new THREE.Mesh(doorTopRightGeometry, bodyMaterial);
    doorTopRight.position.set(-9.5, 19.5, 8);
    pickupTruck.add(doorTopRight);
	
	
	// Door top left
	var doorTopLeftGeometry = new THREE.BoxGeometry(1, 2, 10);
    var doorTopLeft = new THREE.Mesh(doorTopLeftGeometry, bodyMaterial);
    doorTopLeft.position.set(9.5, 19.5, 8);
    pickupTruck.add(doorTopLeft);
	
	
	// Roof
	var roofGeometry = new THREE.BoxGeometry(20, 1, 13);
    var roof = new THREE.Mesh(roofGeometry, bodyMaterial);
    roof.position.set(0, 20, 6.5);
    pickupTruck.add(roof);
	
	
	// Right back window
	var rightBackWindowGeometry = new THREE.BoxGeometry(5.5, 10, 0.2);
    var rightBackWindow = new THREE.Mesh(rightBackWindowGeometry, windowMaterial);
    rightBackWindow.position.set(6.5, 15, 0.5);
    pickupTruck.add(rightBackWindow);
	
	
	// Left back window
	var leftBackWindowGeometry = new THREE.BoxGeometry(5.5, 10, 0.2);
    var leftBackWindow = new THREE.Mesh(leftBackWindowGeometry, windowMaterial);
    leftBackWindow.position.set(-6.5, 15, 0.5);
    pickupTruck.add(leftBackWindow);
	
	
	// Right back window group
	var rightBackWindowGroup = new THREE.Group();
	rightBackWindowGroup.position.set(-4, 15, 0.5);
	pickupTruck.add(rightBackWindowGroup);
	
	// Right back window axis
	var rightBackWindowAxisGeometry = new THREE.CylinderGeometry(0.2, 0.2, 10);
    var rightBackWindowAxis = new THREE.Mesh(rightBackWindowAxisGeometry, axisMaterial);
    rightBackWindowAxis.position.set(0, 0, 0);
    rightBackWindowGroup.add(rightBackWindowAxis);
	
	// Right back movable window
	var rightBackMovableWindowGeometry = new THREE.BoxGeometry(4, 10, 0.2);
    var rightBackMovableWindow = new THREE.Mesh(rightBackMovableWindowGeometry, windowMaterial);
    rightBackMovableWindow.position.set(2, 0, 0);
    rightBackWindowGroup.add(rightBackMovableWindow);
	
	
	// Left back window group
	var leftBackWindowGroup = new THREE.Group();
	leftBackWindowGroup.position.set(4, 15, 0.5);
	pickupTruck.add(leftBackWindowGroup);
	
	// Left back window axis
	var leftBackWindowAxisGeometry = new THREE.CylinderGeometry(0.2, 0.2, 10);
    var leftBackWindowAxis = new THREE.Mesh(leftBackWindowAxisGeometry, axisMaterial);
    leftBackWindowAxis.position.set(0, 0, 0);
    leftBackWindowGroup.add(leftBackWindowAxis);
	
	// Left back movable window
	var leftBackMovableWindowGeometry = new THREE.BoxGeometry(4, 10, 0.2);
    var leftBackMovableWindow = new THREE.Mesh(leftBackMovableWindowGeometry, windowMaterial);
    leftBackMovableWindow.position.set(-2, 0, 0);
    leftBackWindowGroup.add(leftBackMovableWindow);
	
	
	// Right front triangle
	var rightFrontTriangleGeometry = new THREE.Geometry();
	var rightFrontTriangleV1 = new THREE.Vector3(0,0,0);
	var rightFrontTriangleV2 = new THREE.Vector3(15,0,0);
	var rightFrontTriangleV3 = new THREE.Vector3(15,3.5,0);

	rightFrontTriangleGeometry.vertices.push(rightFrontTriangleV1);
	rightFrontTriangleGeometry.vertices.push(rightFrontTriangleV2);
	rightFrontTriangleGeometry.vertices.push(rightFrontTriangleV3);

	rightFrontTriangleGeometry.faces.push(new THREE.Face3( 0, 1, 2 ));
	rightFrontTriangleGeometry.computeFaceNormals();

	var rightFrontTriangle = new THREE.Mesh(rightFrontTriangleGeometry, bodyMaterial);
	rightFrontTriangle.position.set(10, 6.5, 30);
	rightFrontTriangle.rotation.y = 1.6;
	
	pickupTruck.add(rightFrontTriangle);
	
	// Right front helper triangle
	var rightFrontHelperTriangleGeometry = new THREE.Geometry();
	var rightFrontHelperTriangleV1 = new THREE.Vector3(15,0,0);
	var rightFrontHelperTriangleV2 = new THREE.Vector3(0,0,0);
	var rightFrontHelperTriangleV3 = new THREE.Vector3(15,3.5,0);

	rightFrontHelperTriangleGeometry.vertices.push(rightFrontHelperTriangleV1);
	rightFrontHelperTriangleGeometry.vertices.push(rightFrontHelperTriangleV2);
	rightFrontHelperTriangleGeometry.vertices.push(rightFrontHelperTriangleV3);

	rightFrontHelperTriangleGeometry.faces.push(new THREE.Face3( 0, 1, 2 ));
	rightFrontHelperTriangleGeometry.computeFaceNormals();

	var rightFrontHelperTriangle = new THREE.Mesh(rightFrontHelperTriangleGeometry, bodyMaterial);
	rightFrontHelperTriangle.position.set(10, 6.5, 30);
	rightFrontHelperTriangle.rotation.y = 1.6;
	
	pickupTruck.add(rightFrontHelperTriangle);
	
	
	// Left front triangle
	var leftFrontTriangleGeometry = new THREE.Geometry();
	var leftFrontTriangleV1 = new THREE.Vector3(15,0,0);
	var leftFrontTriangleV2 = new THREE.Vector3(0,0,0);
	var leftFrontTriangleV3 = new THREE.Vector3(15,3.5,0);

	leftFrontTriangleGeometry.vertices.push(leftFrontTriangleV1);
	leftFrontTriangleGeometry.vertices.push(leftFrontTriangleV2);
	leftFrontTriangleGeometry.vertices.push(leftFrontTriangleV3);

	leftFrontTriangleGeometry.faces.push(new THREE.Face3( 0, 1, 2 ));
	leftFrontTriangleGeometry.computeFaceNormals();

	var leftFrontTriangle = new THREE.Mesh(leftFrontTriangleGeometry, bodyMaterial);
	leftFrontTriangle.position.set(-9.5, 6.5, 30);
	leftFrontTriangle.rotation.y = 1.6;
	
	pickupTruck.add(leftFrontTriangle);
	
	// Left front helper triangle
	var leftFrontHelperTriangleGeometry = new THREE.Geometry();
	var leftFrontHelperTriangleV1 = new THREE.Vector3(0,0,0);
	var leftFrontHelperTriangleV2 = new THREE.Vector3(15,0,0);
	var leftFrontHelperTriangleV3 = new THREE.Vector3(15,3.5,0);

	leftFrontHelperTriangleGeometry.vertices.push(leftFrontHelperTriangleV1);
	leftFrontHelperTriangleGeometry.vertices.push(leftFrontHelperTriangleV2);
	leftFrontHelperTriangleGeometry.vertices.push(leftFrontHelperTriangleV3);

	leftFrontHelperTriangleGeometry.faces.push(new THREE.Face3( 0, 1, 2 ));
	leftFrontHelperTriangleGeometry.computeFaceNormals();

	var leftFrontHelperTriangle = new THREE.Mesh(leftFrontHelperTriangleGeometry, bodyMaterial);
	leftFrontHelperTriangle.position.set(-9.5, 6.5, 30);
	leftFrontHelperTriangle.rotation.y = 1.6;
	
	pickupTruck.add(leftFrontHelperTriangle);
	
	
	// Right front
	var rightFrontGeometry = new THREE.BoxGeometry(1, 7, 14.5);
    var rightFront = new THREE.Mesh(rightFrontGeometry, bodyMaterial);
    rightFront.position.set(-9.5, 3, 23);
    pickupTruck.add(rightFront);
	
	
	// Left front
	var leftFrontGeometry = new THREE.BoxGeometry(1, 7, 14.5);
    var leftFront = new THREE.Mesh(leftFrontGeometry, bodyMaterial);
    leftFront.position.set(9.5, 3, 23);
    pickupTruck.add(leftFront);
	
	
	// Right front up triangle
	var rightFrontUpTriangleGeometry = new THREE.Geometry();
	var rightFrontUpTriangleV1 = new THREE.Vector3(-1,0,0);
	var rightFrontUpTriangleV2 = new THREE.Vector3(2,0,0);
	var rightFrontUpTriangleV3 = new THREE.Vector3(2,10,0);

	rightFrontUpTriangleGeometry.vertices.push(rightFrontUpTriangleV1);
	rightFrontUpTriangleGeometry.vertices.push(rightFrontUpTriangleV2);
	rightFrontUpTriangleGeometry.vertices.push(rightFrontUpTriangleV3);

	rightFrontUpTriangleGeometry.faces.push(new THREE.Face3( 0, 1, 2 ));
	rightFrontUpTriangleGeometry.computeFaceNormals();

	var rightFrontUpTriangle = new THREE.Mesh(rightFrontUpTriangleGeometry, bodyMaterial);
	rightFrontUpTriangle.position.set(10, 10, 15);
	rightFrontUpTriangle.rotation.y = 1.6;
	
	pickupTruck.add(rightFrontUpTriangle);
	
	// Right front up helper triangle
	var rightFrontUpHelperTriangleGeometry = new THREE.Geometry();
	var rightFrontUpHelperTriangleV1 = new THREE.Vector3(2,0,0);
	var rightFrontUpHelperTriangleV2 = new THREE.Vector3(-1,0,0);
	var rightFrontUpHelperTriangleV3 = new THREE.Vector3(2,10,0);

	rightFrontUpHelperTriangleGeometry.vertices.push(rightFrontUpHelperTriangleV1);
	rightFrontUpHelperTriangleGeometry.vertices.push(rightFrontUpHelperTriangleV2);
	rightFrontUpHelperTriangleGeometry.vertices.push(rightFrontUpHelperTriangleV3);

	rightFrontUpHelperTriangleGeometry.faces.push(new THREE.Face3( 0, 1, 2 ));
	rightFrontUpHelperTriangleGeometry.computeFaceNormals();

	var rightFrontUpHelperTriangle = new THREE.Mesh(rightFrontUpHelperTriangleGeometry, bodyMaterial);
	rightFrontUpHelperTriangle.position.set(10, 10, 15);
	rightFrontUpHelperTriangle.rotation.y = 1.6;
	
	pickupTruck.add(rightFrontUpHelperTriangle);
	
	
	// Left front up triangle
	var leftFrontUpTriangleGeometry = new THREE.Geometry();
	var leftFrontUpTriangleV1 = new THREE.Vector3(2,0,0);
	var leftFrontUpTriangleV2 = new THREE.Vector3(-1,0,0);
	var leftFrontUpTriangleV3 = new THREE.Vector3(2,10,0);

	leftFrontUpTriangleGeometry.vertices.push(leftFrontUpTriangleV1);
	leftFrontUpTriangleGeometry.vertices.push(leftFrontUpTriangleV2);
	leftFrontUpTriangleGeometry.vertices.push(leftFrontUpTriangleV3);

	leftFrontUpTriangleGeometry.faces.push(new THREE.Face3( 0, 1, 2 ));
	leftFrontUpTriangleGeometry.computeFaceNormals();

	var leftFrontUpTriangle = new THREE.Mesh(leftFrontUpTriangleGeometry, bodyMaterial);
	leftFrontUpTriangle.position.set(-9.5, 10, 15);
	leftFrontUpTriangle.rotation.y = 1.6;
	
	pickupTruck.add(leftFrontUpTriangle);
	
	// Left front up helper triangle
	var leftFrontUpHelperTriangleGeometry = new THREE.Geometry();
	var leftFrontUpHelperTriangleV1 = new THREE.Vector3(-1,0,0);
	var leftFrontUpHelperTriangleV2 = new THREE.Vector3(2,0,0);
	var leftFrontUpHelperTriangleV3 = new THREE.Vector3(2,10,0);

	leftFrontUpHelperTriangleGeometry.vertices.push(leftFrontUpHelperTriangleV1);
	leftFrontUpHelperTriangleGeometry.vertices.push(leftFrontUpHelperTriangleV2);
	leftFrontUpHelperTriangleGeometry.vertices.push(leftFrontUpHelperTriangleV3);

	leftFrontUpHelperTriangleGeometry.faces.push(new THREE.Face3( 0, 1, 2 ));
	leftFrontUpHelperTriangleGeometry.computeFaceNormals();

	var leftFrontUpHelperTriangle = new THREE.Mesh(leftFrontUpHelperTriangleGeometry, bodyMaterial);
	leftFrontUpHelperTriangle.position.set(-9.5, 10, 15);
	leftFrontUpHelperTriangle.rotation.y = 1.6;
	
	pickupTruck.add(leftFrontUpHelperTriangle);
	
	
	// Front middle window
	var frontMiddleWindowGeometry = new THREE.BoxGeometry(18, 11, 0.2);
    var frontMiddleWindow = new THREE.Mesh(frontMiddleWindowGeometry, windowMaterial);
    frontMiddleWindow.position.set(0, 14.5, 14.5);
	frontMiddleWindow.rotation.x = -0.3;
    pickupTruck.add(frontMiddleWindow);
	
	
	// Right front middle
	var rightFrontMiddleGeometry = new THREE.BoxGeometry(1, 10, 0.2);
    var rightFrontMiddle = new THREE.Mesh(rightFrontMiddleGeometry, bodyMaterial);
    rightFrontMiddle.position.set(-9.5, 14.5, 14.5);
	rightFrontMiddle.rotation.x = -0.3;
    pickupTruck.add(rightFrontMiddle);
	
	
	// Left front middle
	var leftFrontMiddleGeometry = new THREE.BoxGeometry(1, 10, 0.2);
    var leftFrontMiddle = new THREE.Mesh(leftFrontMiddleGeometry, bodyMaterial);
    leftFrontMiddle.position.set(9.5, 14.5, 14.5);
	leftFrontMiddle.rotation.x = -0.3;
    pickupTruck.add(leftFrontMiddle);
	
	
	// Front wheel axis group
	var frontWheelAxisGroup = new THREE.Group();
	frontWheelAxisGroup.position.set(0, -1, 22);
	pickupTruck.add(frontWheelAxisGroup);
	
	// Front wheel axis
	var frontWheelAxisGeometry = new THREE.BoxGeometry(20, 0.5, 0.5);
    var frontWheelAxis = new THREE.Mesh(frontWheelAxisGeometry, axisMaterial);
    frontWheelAxis.position.set(0, 0, 0);
    frontWheelAxisGroup.add(frontWheelAxis);
	
	// Right front wheel
	var rightFrontWheelGeometry = new THREE.TorusGeometry(3.5, 1.5, 15, 30);
	var rightFrontWheel = new THREE.Mesh(rightFrontWheelGeometry, wheelMaterial);
	rightFrontWheel.position.set(-10, 0, 0);
	rightFrontWheel.rotation.y = 1.6;
	frontWheelAxisGroup.add(rightFrontWheel);
	
	// Left front wheel
	var leftFrontWheelGeometry = new THREE.TorusGeometry(3.5, 1.5, 15, 30);
	var leftFrontWheel = new THREE.Mesh(leftFrontWheelGeometry, wheelMaterial);
	leftFrontWheel.position.set(10, 0, 0);
	leftFrontWheel.rotation.y = 1.6;
	frontWheelAxisGroup.add(leftFrontWheel);
	
	// Right front hubcap
	var rightFrontHubcapGeometry = new THREE.BoxGeometry(5.0, 0.5, 0.5);
	var rightFrontHubcap = new THREE.Mesh(rightFrontHubcapGeometry, bodyMaterial);
	rightFrontHubcap.position.set(-10, 0, 0);
	rightFrontHubcap.rotation.y = 1.6;
	frontWheelAxisGroup.add(rightFrontHubcap);
	
	// Left front hubcap
	var leftFrontHubcapGeometry = new THREE.BoxGeometry(5.0, 0.5, 0.5);
	var leftFrontHubcap = new THREE.Mesh(leftFrontHubcapGeometry, bodyMaterial);
	leftFrontHubcap.position.set(10, 0, 0);
	leftFrontHubcap.rotation.y = 1.6;
	frontWheelAxisGroup.add(leftFrontHubcap);
	
	
	// Back wheel axis group
	var backWheelAxisGroup = new THREE.Group();
	backWheelAxisGroup.position.set(0, -1, -22);
	pickupTruck.add(backWheelAxisGroup);
	
	// Back wheel axis
	var backWheelAxisGeometry = new THREE.BoxGeometry(20, 0.5, 0.5);
    var backWheelAxis = new THREE.Mesh(backWheelAxisGeometry, axisMaterial);
    backWheelAxis.position.set(0, 0, 0);
    backWheelAxisGroup.add(backWheelAxis);
	
	// Right back wheel
	var rightBackWheelGeometry = new THREE.TorusGeometry(3.5, 1.5, 15, 30);
	var rightBackWheel = new THREE.Mesh(rightBackWheelGeometry, wheelMaterial);
	rightBackWheel.position.set(-10, 0, 0);
	rightBackWheel.rotation.y = 1.6;
	backWheelAxisGroup.add(rightBackWheel);
	
	// Left back wheel
	var leftBackWheelGeometry = new THREE.TorusGeometry(3.5, 1.5, 15, 30);
	var leftBackWheel = new THREE.Mesh(leftBackWheelGeometry, wheelMaterial);
	leftBackWheel.position.set(10, 0, 0);
	leftBackWheel.rotation.y = 1.6;
	backWheelAxisGroup.add(leftBackWheel);
	
	// Right back hubcap
	var rightBackHubcapGeometry = new THREE.BoxGeometry(5.0, 0.5, 0.5);
	var rightBackHubcap = new THREE.Mesh(rightBackHubcapGeometry, bodyMaterial);
	rightBackHubcap.position.set(-10, 0, 0);
	rightBackHubcap.rotation.y = 1.6;
	backWheelAxisGroup.add(rightBackHubcap);
	
	// Left back hubcap
	var leftBackHubcapGeometry = new THREE.BoxGeometry(5.0, 0.5, 0.5);
	var leftBackHubcap = new THREE.Mesh(leftBackHubcapGeometry, bodyMaterial);
	leftBackHubcap.position.set(10, 0, 0);
	leftBackHubcap.rotation.y = 1.6;
	backWheelAxisGroup.add(leftBackHubcap);
	

	// Front right light
	var frontRightGeometry = new THREE.CircleGeometry(2, 10);
    var frontRight = new THREE.Mesh(frontRightGeometry, windowMaterial);
    frontRight.position.set(7.5, 4.5, 30.5);
    pickupTruck.add(frontRight);


	// Front left light
	var frontRightGeometry = new THREE.CircleGeometry(2, 10);
    var frontRight = new THREE.Mesh(frontRightGeometry, windowMaterial);
    frontRight.position.set(-7.5, 4.5, 30.5);
    pickupTruck.add(frontRight);

	
	// add a lightsource - at the camera
	// var pointLight = new THREE.SpotLight(0xeeeeee);
	// pointLight.position.x = original_eye.x;
	// pointLight.position.y = original_eye.y;
	// pointLight.position.z = original_eye.z;
	// pointLight.itensity = 100;
	// scene.add(pointLight);

	// add a bit of ambient light to make things brighter
	var pointLight = new THREE.PointLight(0xC8C8C8);
	camera.add(pointLight);
	scene.add(camera);


	renderer = new THREE.WebGLRenderer( { antialias: true } );
	renderer.setPixelRatio( window.devicePixelRatio );
	renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
	container.appendChild( renderer.domElement );

	renderer.autoClear = false;
	
	// OrbitControls
	var orbit_controls = new THREE.OrbitControls(camera, renderer.domElement);
	orbit_controls.enableZoom = true;
	
	const epsilon = 1e-5;
	
	var controls = new function () {
		
		this.left_line = d_left_line + epsilon;
		this.right_line = d_right_line + epsilon;
		this.top_line = d_top_line + epsilon;
		this.bottom_line = d_bottom_line + epsilon;
		this.near_line = d_near_line + epsilon;
		this.far_line = d_far_line + epsilon;
		
		this.updateCamera = function() {
			cameraOrtho.left = d_left_line + frustum_var * aspect / - 2;
			cameraOrtho.right = d_right_line + frustum_var * aspect / 2;
			cameraOrtho.bottom = d_bottom_line + frustum_var * aspect / -2 * 0.2;
			cameraOrtho.top = d_top_line + frustum_var * aspect / 2 * 0.2;
			cameraOrtho.near = d_near_line + 3;
			cameraOrtho.far = d_far_line + far_view_ortho;
		}
		
		this.frustum = function () {
			if(controls.left_line)
				d_left_line = controls.left_line;
			if(controls.right_line)
				d_right_line = controls.right_line;
			if(controls.top_line)
				d_top_line = controls.top_line;
			if(controls.bottom_line)
				d_bottom_line = controls.bottom_line;
			if(controls.near_line)
				d_near_line = controls.near_line;
			if(controls.far_line)
				d_far_line = controls.far_line;
			if(controls.eye_x)
				d_eye_x = controls.eye_x;
			if(controls.eye_y)
				d_eye_y = controls.eye_y;
			if(controls.eye_z)
				d_eye_z = controls.eye_z;
			updateFrustum(this);
		}
		
		this.updateFrustum = function() {
			this.updateCamera();
		}
		
		this.deactivate_orbit_controls = function () {
			if (orbit_controls.enabled) {
				orbit_controls.enabled = false;
			} else {
				orbit_controls.enabled = true;
			}
		};

	}
	
	function updateFrustum( cntrl ) {
		controls.updateFrustum()
	}
	
	// Car movement functions
	var rightDoorControl = new function () {
		this.rightDoor = 0;
    };
	
	var leftWindowControl = new function () {
		this.leftWindow = 9;
    };
	
	var leftDoorControl = new function () {
		this.leftDoor = 0;
    };
	
	var rightWindowControl = new function () {
		this.rightWindow = 9;
    };
	
	var trunkControl = new function () {
		this.trunk = 0;
    };
	
	var hoodControl = new function () {
		this.hood = 0;
    };
	
	var rightBackWindowControl = new function () {
		this.rightBackWindow = 2;
	}
	
	var leftBackWindowControl = new function () {
		this.leftBackWindow = -2;
	}
	
	var moveForwardControl = new function () {
		this.moveForward
	}
	
	var gui = new dat.GUI();
	gui.add(controls, 'left_line', -0.0, 600.0).onChange(controls.frustum);
	gui.add(controls, 'right_line', -600.0, 0.0).onChange(controls.frustum);
	gui.add(controls, 'top_line', -100.0, 0.0).onChange(controls.frustum);
	gui.add(controls, 'bottom_line', -0.0, 100.0).onChange(controls.frustum);
	gui.add(controls, 'near_line', -10.0, 200.0).onChange(controls.frustum);	
	gui.add(controls, 'far_line', -400.0, 50.0).onChange(controls.frustum);
	gui.add(controls, 'deactivate_orbit_controls');
	
	// Car controls
	gui.add(rightDoorControl, 'rightDoor', 0, 12)
	gui.add(leftWindowControl, 'leftWindow', 0, 9)
	gui.add(leftDoorControl, 'leftDoor', -12, 0)
	gui.add(rightWindowControl, 'rightWindow', 0, 9)
	gui.add(trunkControl, 'trunk', -15, 0)
	gui.add(hoodControl, 'hood', -15, 0)
	gui.add(rightBackWindowControl, 'rightBackWindow', -2, 2)
	gui.add(leftBackWindowControl, 'leftBackWindow', -2, 2)
	
	render();
	
	document.addEventListener("keydown", onDocumentKeyDown, false);
	
	function onDocumentKeyDown(event) {
		var keyCode = event.which;
		if (keyCode == 87) {
			zSpeed += initialZSpeed;
		} else if (keyCode == 83) {
			zSpeed -= initialZSpeed;
		}
	};

	function render() {
		// Car movement
		rightDoorGroup.rotation.y = 0.1 * rightDoorControl.rightDoor;
		leftWindow.position.y = 1 * leftWindowControl.leftWindow;
		leftDoorGroup.rotation.y = 0.1 * leftDoorControl.leftDoor;
		rightWindow.position.y = 1 * rightWindowControl.rightWindow;
		backGroup.rotation.x = 0.1 * trunkControl.trunk;
		hoodGroup.rotation.x = 0.1 * hoodControl.hood;
		rightBackMovableWindow.position.x = 1 * rightBackWindowControl.rightBackWindow;
		leftBackMovableWindow.position.x = 1 * leftBackWindowControl.leftBackWindow;
		pickupTruck.position.z += zSpeed;
		frontWheelAxisGroup.rotation.x += zSpeed / 2;
		backWheelAxisGroup.rotation.x += zSpeed/2
		
		requestAnimationFrame( render );
		
		cameraOrtho.updateProjectionMatrix();
		cameraOrthoHelper.update();
		
		cameraOrtho.lookAt( origin );

		renderer.setViewport( 0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
		renderer.render( scene, camera );

		renderer.setViewport( SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
		renderer.render( scene, cameraOrtho );
	}
	
}

window.onload = main;