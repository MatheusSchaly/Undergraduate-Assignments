<ncl id="myNCLDocID" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<connectorBase id="connectorBase1">
			<causalConnector id="onEndStart">
				<simpleCondition role="onEnd">
				</simpleCondition>
				<simpleAction role="start">
				</simpleAction>
			</causalConnector>
			<causalConnector id="onBeginStart">
				<simpleAction role="start">
				</simpleAction>
				<simpleCondition role="onBegin">
				</simpleCondition>
			</causalConnector>
			<causalConnector id="onKeySelectionStartStopAbort">
				<connectorParam name="keyCode">
				</connectorParam>
				<simpleCondition key="$keyCode" role="onSelection">
				</simpleCondition>
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="start">
					</simpleAction>
					<simpleAction max="unbounded" qualifier="par" role="stop">
					</simpleAction>
					<simpleAction max="unbounded" qualifier="par" role="abort">
					</simpleAction>
				</compoundAction>
			</causalConnector>
			<causalConnector id="onKeySelectionStartStop">
				<connectorParam name="keyCode">
				</connectorParam>
				<simpleCondition key="$keyCode" role="onSelection">
				</simpleCondition>
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="start">
					</simpleAction>
					<simpleAction max="unbounded" qualifier="par" role="stop">
					</simpleAction>
				</compoundAction>
			</causalConnector>
		</connectorBase>
		<descriptorBase id="descriptorBase1">
			<descriptor id="dscTV" region="rgTV">
			</descriptor>
			<descriptor id="dscLogo" region="rgLogo">
			</descriptor>
			<descriptor id="dscCenter" region="rgCenter">
			</descriptor>
		</descriptorBase>
		<regionBase id="regionBase1">
			<region height="100.00%" id="rgTV" left="0.00%" top="0.00%" width="100.00%" zIndex="1">
			</region>
			<region height="10.00%" id="rgLogo" left="4.92%" top="82.50%" width="10.00%" zIndex="2">
			</region>
			<region height="51.67%" id="rgCenter" left="17.33%" top="17.29%" width="64.75%" zIndex="2">
			</region>
		</regionBase>
	</head>
	<body id="myBodyID">
		<media descriptor="dscTV" id="Video" src="media/video1.mpg" type="video/mpeg">
		</media>
		<media descriptor="dscLogo" id="logoVerde" src="media/botao_verde.gif" type="image/gif">
		</media>
		<media descriptor="dscLogo" id="interatividadeVermelha" src="media/interat.gif" type="image/gif">
		</media>
		<media descriptor="dscCenter" id="Pagina1" src="media/Pagina1.gif" type="image/gif">
		</media>
		<media descriptor="dscCenter" id="Pagina2" src="media/Pagina2.gif" type="image/gif">
		</media>
		<media descriptor="dscCenter" id="Pagina3" src="media/Pagina3.gif" type="image/gif">
		</media>
		<port component="interatividadeVermelha" id="port1">
		</port>
		<link id="link1" xconnector="onBeginStart">
			<bind component="interatividadeVermelha" role="onBegin">
			</bind>
			<bind component="Video" role="start">
			</bind>
		</link>
		<link id="link2" xconnector="onEndStart">
			<bind component="Video" role="onEnd">
			</bind>
			<bind component="Video" role="start">
			</bind>
		</link>
		<link id="link3" xconnector="onKeySelectionStartStop">
			<bind component="interatividadeVermelha" role="onSelection">
				<bindParam name="keyCode" value="RED">
				</bindParam>
			</bind>
			<bind component="Pagina1" role="start">
			</bind>
			<bind component="interatividadeVermelha" role="stop">
			</bind>
		</link>
		<link id="link4" xconnector="onKeySelectionStartStopAbort">
			<bind component="Pagina1" role="onSelection">
				<bindParam name="keyCode" value="GREEN">
				</bindParam>
			</bind>
			<bind component="Pagina2" role="start">
			</bind>
			<bind component="Pagina1" role="stop">
			</bind>
			<bind component="Pagina1" role="abort">
			</bind>
		</link>
		<link id="link5" xconnector="onKeySelectionStartStopAbort">
			<bind component="Pagina2" role="onSelection">
				<bindParam name="keyCode" value="GREEN">
				</bindParam>
			</bind>
			<bind component="Pagina3" role="start">
			</bind>
			<bind component="Pagina2" role="stop">
			</bind>
			<bind component="Pagina2" role="abort">
			</bind>
		</link>
		<link id="link6" xconnector="onKeySelectionStartStopAbort">
			<bind component="Pagina3" role="onSelection">
				<bindParam name="keyCode" value="BLUE">
				</bindParam>
			</bind>
			<bind component="Pagina1" role="start">
			</bind>
			<bind component="Pagina3" role="stop">
			</bind>
			<bind component="Pagina3" role="abort">
			</bind>
		</link>
		<link id="link7" xconnector="onKeySelectionStartStopAbort">
			<bind component="Pagina3" role="onSelection">
				<bindParam name="keyCode" value="RED">
				</bindParam>
			</bind>
			<bind component="interatividadeVermelha" role="start">
			</bind>
			<bind component="Pagina3" role="stop">
			</bind>
			<bind component="Pagina3" role="abort">
			</bind>
		</link>
	</body>
</ncl>
