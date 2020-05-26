function main() {
		
	var SCREEN_WIDTH = window.innerWidth;
	var SCREEN_HEIGHT = window.innerHeight;
	var aspect = SCREEN_WIDTH / SCREEN_HEIGHT;

	var container, stats;
	var camera, scene, renderer, mesh;
	var cameraRig, activeCamera, activeHelper;
	var cameraPerspective, cameraOrtho;
	var cameraPerspectiveHelper, cameraOrthoHelper;
	var frustumSize = 100;

		container = document.createElement( 'div' );
		document.body.appendChild( container );

		scene = new THREE.Scene();

		// camera = new THREE.PerspectiveCamera( 50, 0.5 * aspect, 1, 10000 );
		camera = new THREE.OrthographicCamera( -100 + 0.5 * frustumSize * aspect / - 2, 0.5 * frustumSize * aspect / 2, frustumSize / 2, frustumSize / - 2, 100, 2000 );
		camera.position.z = 500;
		camera.position.x = 270;
		camera.rotation.y = 0.3;
		
		cameraPerspective = new THREE.PerspectiveCamera( 50, 0.5 * aspect, 100, 150 );
		cameraPerspectiveHelper = new THREE.CameraHelper( cameraPerspective );
		scene.add( cameraPerspectiveHelper );
		
		cameraOrtho = new THREE.OrthographicCamera( 0.5 * frustumSize * aspect / - 2, 0.5 * frustumSize * aspect / 2, frustumSize / 2, frustumSize / - 2, 150, 1000 );
		cameraOrthoHelper = new THREE.CameraHelper( cameraOrtho );
		scene.add( cameraOrthoHelper );

		activeCamera = cameraPerspective;
		activeHelper = cameraPerspectiveHelper;

		cameraPerspective.rotation.y = Math.PI;

		cameraRig = new THREE.Group();

		cameraRig.add( cameraPerspective );
		cameraRig.add( cameraOrtho );

		scene.add( cameraRig );
		
		//

		mesh = new THREE.Mesh(
			new THREE.SphereBufferGeometry( 4, 16, 8 ),
			new THREE.MeshBasicMaterial( { color: 0xffffff, wireframe: true } )
		);
		scene.add( mesh );

		//

		var geometry = new THREE.BufferGeometry();
		var vertices = [];

		geometry.setAttribute( 'position', new THREE.Float32BufferAttribute( vertices, 3 ) );

		//

		renderer = new THREE.WebGLRenderer( { antialias: true } );
		renderer.setPixelRatio( window.devicePixelRatio );
		renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
		container.appendChild( renderer.domElement );

		renderer.autoClear = false;
		
		render();

		function render() {
		
			requestAnimationFrame( render );
			var r = Date.now() * 0.0005;

			mesh.position.x = 80

			if ( activeCamera === cameraPerspective ) {

				cameraPerspective.fov = 10
				cameraPerspective.far = mesh.position.length() - 20;
				cameraPerspective.updateProjectionMatrix();

				cameraPerspectiveHelper.update();
				cameraPerspectiveHelper.visible = true;

				cameraOrthoHelper.visible = false;

			} else {

				cameraOrtho.far = mesh.position.length();
				cameraOrtho.updateProjectionMatrix();

				cameraOrthoHelper.update();
				cameraOrthoHelper.visible = true;

				cameraPerspectiveHelper.visible = false;

			}

			cameraRig.lookAt( mesh.position );

			renderer.clear();

			activeHelper.visible = false;

			renderer.setViewport( 0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
			renderer.render( scene, activeCamera );

			activeHelper.visible = true;

			renderer.setViewport( SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT );
			renderer.render( scene, camera );

	}

}

window.onload = main;