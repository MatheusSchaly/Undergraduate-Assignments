var scene = new THREE.Scene();

var object;


function main() {
	function loadModel() {
		object.traverse( function ( child ) {
			if ( child.isMesh ) { child.material.map = texture; }
		});

		// Scale object to size 2 and center it		
		const box = new THREE.Box3().setFromObject(object);
		const boxSize = box.getSize(new THREE.Vector3());
		// Find maximum dimension
		const boxSizeln = Math.max( boxSize.x, boxSize.y, boxSize.z );
		// Find box center	
		const boxCenter = box.getCenter(new THREE.Vector3());
		// set position and scale
		object.position.set( -2.0*boxCenter.x/boxSizeln, 
							 -2.0*boxCenter.y/boxSizeln, 
							 -2.0*boxCenter.z/boxSizeln );
		object.scale.set( 2.0/boxSizeln, 2.0/boxSizeln, 2.0/boxSizeln ); 
	
		scene.add( object );
	}

	var manager = new THREE.LoadingManager( loadModel );
	manager.onProgress = function ( item, loaded, total ) {
		console.log( item, loaded, total );
	};

	var textureLoader = new THREE.TextureLoader( manager );
	var texture = textureLoader.load( '../../models/tiger.jpg' );

    function onProgress( xhr ) {
		if ( xhr.lengthComputable ) {
			var percentComplete = xhr.loaded / xhr.total * 100;
			console.log( 'model ' + Math.round( percentComplete, 2 ) + '% downloaded' );
		}
	}

	function onError() {}

	var loader = new THREE.OBJLoader( manager );
	loader.load( '../../models/tiger.obj', function ( obj ) {object = obj;}, onProgress, onError );

	init()
}


// initialization of Three.js
function init() {
	if (THREE.WEBGL.isWebGLAvailable() === false) {
		document.body.appendChild(THREE.WEBGL.getWebGLErrorMessage());
	}
	// add our rendering surface and initialize the renderer
	var container = document.createElement('div');
	document.body.appendChild(container);
	// WebGL2 examples suggest we need a canvas
	// canvas = document.createElement( 'canvas' );
	// var context = canvas.getContext( 'webgl2' );
	// var renderer = new THREE.WebGLRenderer( { canvas: canvas, context: context } );
	renderer = new THREE.WebGLRenderer();
	// set some state - here just clear color
	renderer.setClearColor(new THREE.Color(0x333333));
	renderer.setSize(window.innerWidth, window.innerHeight);
	// add the output of the renderer to the html element
	container.appendChild(renderer.domElement);

  
	// need a camera to look at the object
	// calculate aspectRatio
	var aspectRatio = window.innerWidth / window.innerHeight;
	// Default constants
	var eye = new THREE.Vector3( 0.0, 0.0, 5.0 );
	var at = new THREE.Vector3( 0.0, 0.0, 0.0);
	var up = new THREE.Vector3( 0.0, 1.0, 0.0);

	var d_width = 2.0;
	var d_height = 2.0;
	var d_near = 4.0;
	var d_far = 6.0;

	var cameraOrtho;
	var cameraOrthoHelper;
	var frustumSize = 600;
  
	// Camera needs to be global
	camera = new THREE.OrthographicCamera(-d_width/2.0 * aspectRatio, d_width/2.0 *aspectRatio, d_height/2.0, -d_height/2.0, d_near, d_far);
	// camera = new THREE.PerspectiveCamera(Math.atan(1.0/4.0)*360.0/Math.PI, aspectRatio, 4, 6);
	// position the camera - remainder is default
	camera.position.copy(eye);

	// add a lightsource - at the camera
	let pointLight = new THREE.PointLight(0xeeeeee);
	camera.add(pointLight);

	// add a bit of ambient light to make things brighter
	let ambientLight = new THREE.AmbientLight(0x909090)
	scene.add(ambientLight)

	// CameraOrtho
	cameraOrtho = new THREE.OrthographicCamera( 0.5 * frustumSize * aspectRatio / - 2, 0.5 * frustumSize * aspectRatio / 2, frustumSize / 2, frustumSize / - 2, 150, 1000 );
	CameraOrthoHelper = new THREE.CameraHelper(cameraOrtho);
	//scene.add(cameraOrthoHelper);

	var axes = new THREE.AxesHelper(10);
	scene.add(axes);

	const epsilon = 1e-5;

	var controls = new function () {
		this.perspective = "Orthographic";
		this.eye_x = eye.x + epsilon;
		this.eye_y = eye.y + epsilon;
		this.eye_z = eye.z + epsilon;
		this.at_x = at.x + epsilon;
		this.at_y = at.y + epsilon;
		this.at_z = at.z + epsilon;
		this.up_x = up.x + epsilon;
		this.up_y = up.y + epsilon;
		this.up_z = up.z + epsilon;
		this.width = d_width + epsilon;
		this.height = d_height + epsilon;
		this.near = d_near + epsilon;
		this.far = d_far + epsilon;
	
		this.update = function() {
		if(controls.eye_x )
			eye.x = controls.eye_x;
		if(controls.eye_y)
			eye.y = controls.eye_y;
		if(controls.eye_z)
			eye.z = controls.eye_z;
		if(controls.at_x)
			at.x = controls.at_x;
		if(controls.at_y)
			at.y = controls.at_y;
		if(controls.at_z)
			at.z = controls.at_z;
		if(controls.up_x)
			up.x = controls.up_x;
		if(controls.up_y)
			up.y = controls.up_y;
		if(controls.up_z)
			up.z = controls.up_z;
			updateLookAt();
		};

		this.updateCamera = function( isPerspective ) {
			var aspectRatio = window.innerWidth / window.innerHeight;
			if ( isPerspective ) {
				camera = new 
					THREE.PerspectiveCamera(Math.atan(this.height/this.near/2.0)*360.0/Math.PI,					 								this.width/this.height * aspectRatio, this.near, this.far);
				this.perspective = "Perspective";
			} else {
				camera = new THREE.OrthographicCamera(-this.width/2.0 * aspectRatio, this.width/2.0 *aspectRatio, this.height/2.0, -this.height/2.0, this.near, this.far);
				this.perspective = "Orthographic";
			}
		camera.updateProjectionMatrix();
		};

		this.switchCamera = function () {
			if (camera instanceof THREE.PerspectiveCamera) {
				this.updateCamera(false);
			} else {
				this.updateCamera(true);
			}
		};

		this.frustum = function () {
			if(controls.width )
				d_width = controls.width;
			if(controls.height)
				d_height = controls.height;
			if(controls.near)
				d_near = controls.near;
			if(controls.far)
				d_far = controls.far;
				updateFrustum(this);
		}
		
		this.updateFrustum = function() {
			if (camera instanceof THREE.PerspectiveCamera) {
				this.updateCamera(true);
			} else {
				this.updateCamera(false);
			}
		};
	};

	function updateFrustum( cntrl ) {
		controls.updateFrustum()
	}
	
	var gui = new dat.GUI();
	gui.add(controls, 'eye_x', -5.0, 5.0).onChange(controls.update);
	gui.add(controls, 'eye_y', -5.0, 5.0).onChange(controls.update);
	gui.add(controls, 'eye_z', -5.0, 5.0).onChange(controls.update);
	gui.add(controls, 'at_x', -5.0, 5.0).onChange(controls.update);
	gui.add(controls, 'at_y', -5.0, 5.0).onChange(controls.update);
	gui.add(controls, 'at_z', -5.0, 5.0).onChange(controls.update);
	gui.add(controls, 'up_x', -1.0, 1.0).onChange(controls.update);
	gui.add(controls, 'up_y', -1.0, 1.0).onChange(controls.update);
	gui.add(controls, 'up_z', -1.0, 1.0).onChange(controls.update);
	gui.add(controls, 'switchCamera');
	gui.add(controls, 'perspective').listen();
	gui.add(controls, 'width', 0.01, 20.0).onChange(controls.frustum);	
	gui.add(controls, 'height', 0.01, 20.0).onChange(controls.frustum);	
	gui.add(controls, 'near', 0.01, 20.0).onChange(controls.frustum);
	gui.add(controls, 'far', 0.01, 20.0).onChange(controls.frustum);
	gui.add(controls, 'updateFrustum');

	render();

	function onResize() {
		camera.aspect = window.innerWidth / window.innerHeight;
		camera.updateProjectionMatrix();
		// If we use a canvas then we also have to worry of resizing it
		renderer.setSize(window.innerWidth, window.innerHeight);
	}
	window.addEventListener('resize', onResize, true);


	function render() {
		// render using requestAnimationFrame - register function
		requestAnimationFrame(render);
		updateLookAt();
		renderer.render(scene, camera);
	}

	function updateLookAt() {
		camera.position.copy(eye);
		camera.up.copy(up);
		camera.lookAt(at);
		camera.updateMatrix();
	}
}

window.onload = main;

// register our resize event function
// window.addEventListener('resize', onResize, true);
