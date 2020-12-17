var origin = new THREE.Vector3( 0, 0, 0 );
var eye = new THREE.Vector3( -2, -2, 20);

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
	var d_width = 0;
	var frustum = 5;

	container = document.createElement( 'div' );
	document.body.appendChild( container );

	camera = new THREE.OrthographicCamera( d_width + 10 * aspect / - 2, d_width + 10 * aspect / 2, 5 / 2, 5 / - 2, 0, 300 );
	camera.position.x = eye.x;
	camera.position.y = eye.y;
	camera.position.z = eye.z;
	
	cameraOrtho = new THREE.OrthographicCamera( frustum * aspect / - 2, frustum * aspect / 2, frustum * aspect / 2 * 0.2, frustum * aspect / - 2 * 0.2, 3, 13 );
	console.log("DDD" + frustum * aspect / - 2)
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
		this.width = d_width + epsilon;
		
		this.update = function() {
		}
		
		this.updateCamera = function() {
			console.log(d_width)
			console.log("AAA")
			console.log(d_width = 0)
			console.log("CCC" + d_width + frustum * aspect / - 2)
			cameraOrtho = new THREE.OrthographicCamera(d_width + frustum * aspect / - 2, d_width + frustum * aspect / 2, frustum * aspect / 2 * 0.2, frustum * aspect / - 2 * 0.2, 3, 13 )
			// camera = new THREE.OrthographicCamera(-this.width/2.0 * aspectRatio, this.width/2.0 *aspectRatio, this.height/2.0, -this.height/2.0, this.near, this.far);
			cameraOrtho.updateProjectionMatrix();
		}
		
		this.frustum = function () {
			if(controls.width )
				d_width = controls.width;
			updateFrustum(this);
		}
		
		this.updateFrustum = function() {
			this.updateCamera();
		}
	}
	
	function updateFrustum( cntrl ) {
		controls.updateFrustum()
	}
	
	console.log("BBB")
	console.log(d_width)
	var gui = new dat.GUI();
	gui.add(controls, 'width', -5.0, 5.0).onChange(controls.frustum);
	
	render();
			
			
	function render() {
		requestAnimationFrame( render );
		
		cameraOrtho.updateProjectionMatrix();

		cameraOrthoHelper.update();
		cameraOrthoHelper.visible = true;

		camera.lookAt( origin );
		cameraOrtho.lookAt( origin );

		renderer.clear();

		renderer.setViewport( 0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
		renderer.render( scene, cameraOrtho );

		renderer.setViewport( SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
		renderer.render( scene, camera );
	}
	
}

window.onload = main;