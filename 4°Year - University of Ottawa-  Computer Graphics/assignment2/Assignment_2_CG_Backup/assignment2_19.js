var origin = new THREE.Vector3( 0, 0, 0 );
var original_eye = new THREE.Vector3( -2, -2, 20);

scene = new THREE.Scene();
var object;

function main() {
		// Loads the model
	function loadModel() {
		object.traverse( function ( child ) {
			if ( child.isMesh ) { child.material.map = texture; }
		});
		// set position and scale
		object.position.set(origin.x, origin.y, origin.z)
		object.scale.set( 0.05, 0.05, 0.05);
	
		scene.add( object );
	}

	var manager = new THREE.LoadingManager( loadModel );
	manager.onProgress = function ( item, loaded, total ) {
		console.log( item, loaded, total );
	};

	var textureLoader = new THREE.TextureLoader( manager );
	var texture = textureLoader.load( 'models/tiger.jpg' );

    function onProgress( xhr ) {
		if ( xhr.lengthComputable ) {
			var percentComplete = xhr.loaded / xhr.total * 100;
			console.log( 'model ' + Math.round( percentComplete, 2 ) + '% downloaded' );
		}
	}

	function onError() {}

	var loader = new THREE.OBJLoader( manager );
	loader.load( 'models/tiger.obj', function ( obj ) {object = obj;}, onProgress, onError );

	init();
}

function init() {
		
	var SCREEN_WIDTH = window.innerWidth;
	var SCREEN_HEIGHT = window.innerHeight;
	var aspect = SCREEN_WIDTH / SCREEN_HEIGHT;

	var container, stats;
	var camera, renderer;
	var cameraRig, activeCamera;
	var cameraOrtho;
	var cameraOrthoHelper;
	var d_left_line = 0, d_right_line = 0; 
	var d_top_line = 0, d_bottom_line = 0;
	var d_near_line = 0, d_far_line = 0;
	var d_eye_x = 0, d_eye_y = 0, d_eye_z = 0;
	var frustum_var = 5;

	container = document.createElement( 'div' );
	document.body.appendChild( container );

	camera = new THREE.OrthographicCamera(frustum_var * 2 * aspect / - 2, frustum_var * 2 * aspect / 2, frustum_var / 2, frustum_var / - 2, 0, 300 );
	camera.position.x = original_eye.x;
	camera.position.y = original_eye.y;
	camera.position.z = original_eye.z;
	
	cameraOrtho = new THREE.OrthographicCamera( frustum_var * aspect / - 2, frustum_var * aspect / 2, frustum_var * aspect / 2 * 0.2, frustum_var * aspect / - 2 * 0.2, 3, 13 );
	cameraOrthoHelper = new THREE.CameraHelper( cameraOrtho );
	cameraOrtho.position.y = 0;
	cameraOrtho.position.x = -7;
	cameraOrtho.position.z = 0;
	
	
	scene.add( cameraOrthoHelper );
	
	//
	
	// add a lightsource - at the camera
	let pointLight = new THREE.PointLight(0xeeeeee);
	camera.add(pointLight);

	// add a bit of ambient light to make things brighter
	let ambientLight = new THREE.AmbientLight(0x909090)
	scene.add(ambientLight)

	//

	renderer = new THREE.WebGLRenderer( { antialias: true } );
	renderer.setPixelRatio( window.devicePixelRatio );
	renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
	container.appendChild( renderer.domElement );

	renderer.autoClear = false;
	
	const epsilon = 1e-5;
	
	var controls = new function () {
		this.left_line = d_left_line + epsilon;
		this.right_line = d_right_line + epsilon;
		this.top_line = d_top_line + epsilon;
		this.bottom_line = d_bottom_line + epsilon;
		this.near_line = d_near_line + epsilon;
		this.far_line = d_far_line + epsilon;
		this.eye_x = d_eye_x + epsilon;
		this.eye_y = d_eye_y + epsilon;
		this.eye_z = d_eye_z + epsilon;
		
		this.updateCamera = function() {
			cameraOrtho.left = d_left_line + frustum_var * aspect / - 2;
			cameraOrtho.right = d_right_line + frustum_var * aspect / 2;
			cameraOrtho.bottom = d_bottom_line + frustum_var * aspect / -2 * 0.2;
			cameraOrtho.top = d_top_line + frustum_var * aspect / 2 * 0.2;
			cameraOrtho.near = d_near_line + 3;
			cameraOrtho.far = d_far_line + 13;
			
			console.log("Original X:", camera.position.x)
			console.log("Original Y:", camera.position.y)
			console.log("Original Z:", camera.position.z)
			
			camera.position.x = original_eye.x + d_eye_x
			camera.position.y = original_eye.y + d_eye_y
			camera.position.z = original_eye.z + d_eye_z
			
			console.log("New X:", camera.position.x)
			console.log("New Y:", camera.position.y)
			console.log("New Z:", camera.position.z)

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
	}
	
	function updateFrustum( cntrl ) {
		controls.updateFrustum()
	}
	
	var gui = new dat.GUI();
	gui.add(controls, 'left_line', -8.0, 8.0).onChange(controls.frustum);
	gui.add(controls, 'right_line', -8.0, 8.0).onChange(controls.frustum);
	gui.add(controls, 'top_line', -8.0, 8.0).onChange(controls.frustum);
	gui.add(controls, 'bottom_line', -8.0, 8.0).onChange(controls.frustum);
	gui.add(controls, 'near_line', -8.0, 8.0).onChange(controls.frustum);	
	gui.add(controls, 'far_line', -8.0, 8.0).onChange(controls.frustum);
	gui.add(controls, 'eye_x', -100.0, 100.0).onChange(controls.frustum);
	gui.add(controls, 'eye_y', -100.0, 100.0).onChange(controls.frustum);
	gui.add(controls, 'eye_z', -100.0, 100.0).onChange(controls.frustum);
	
	render();

	function render() {
		requestAnimationFrame( render );
		
		cameraOrtho.updateProjectionMatrix();
		cameraOrthoHelper.update();

		camera.lookAt( origin );
		cameraOrtho.lookAt( origin );

		renderer.setViewport( 0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
		renderer.render( scene, cameraOrtho );

		renderer.setViewport( SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
		renderer.render( scene, camera );
	}
	
}

window.onload = main;