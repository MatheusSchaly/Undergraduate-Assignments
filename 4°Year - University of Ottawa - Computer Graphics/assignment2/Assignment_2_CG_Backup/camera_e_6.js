var scene = new THREE.Scene();
var object;

function main() {
	
	// Loads the model
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
	
	init()	
}

function init() {
	if (THREE.WEBGL.isWebGLAvailable() === false) {
		document.body.appendChild(THREE.WEBGL.getWebGLErrorMessage());
	}
	var container = document.createElement('div');
	document.body.appendChild(container);
	renderer = new THREE.WebGLRenderer();
	renderer.setClearColor(new THREE.Color(0x333333));
	renderer.setSize(window.innerWidth, window.innerHeight);
	container.appendChild(renderer.domElement);
	
	var aspect = window.innerWidth / window.innerHeight;
	var eye = new THREE.Vector3( 0.0, 0.0, 5.0 );
	var at = new THREE.Vector3( 0.0, 0.0, 0.0);
	var up = new THREE.Vector3( 0.0, 1.0, 0.0);
	var frustumSize = 600;
	var d_width = 2.0;
	var d_height = 2.0;
	var d_near = 4.0;
	var d_far = 50.0;
	
	camera = new THREE.PerspectiveCamera( 50, 0.5 * aspect, 1, 10000 );
	camera.position.z = 2500;

	cameraPerspective = new THREE.PerspectiveCamera( 50, 0.5 * aspect, 150, 1000 );
	cameraPerspectiveHelper = new THREE.CameraHelper( cameraPerspective );
	scene.add( cameraPerspectiveHelper );

	cameraOrtho = new THREE.OrthographicCamera( 0.5 * frustumSize * aspect / - 2, 0.5 * frustumSize * aspect / 2, frustumSize / 2, frustumSize / - 2, 150, 1000 );
	cameraOrthoHelper = new THREE.CameraHelper( cameraOrtho );
	scene.add( cameraOrthoHelper );
	
	activeCamera = cameraPerspective;
	activeHelper = cameraPerspectiveHelper;
	
	cameraRig = new THREE.Group();
	cameraRig.add( cameraPerspective );
	cameraRig.add( cameraOrtho );

	scene.add( cameraRig );

	// add a lightsource - at the camera
	let pointLight = new THREE.PointLight(0xeeeeee);
	camera.add(pointLight);
	// add a bit of ambient light to make things brighter
	let ambientLight = new THREE.AmbientLight(0x909090)
	scene.add(ambientLight)

	render();
	
	function render() {
		requestAnimationFrame(render);
		camera.updateProjectionMatrix();
		cameraPerspective.updateProjectionMatrix();
		cameraOrtho.updateProjectionMatrix();
		renderer.render( scene, camera );
		renderer.render( scene, cameraPerspective );
		renderer.render( scene, cameraOrtho );
	}
	
}

window.onload = main;