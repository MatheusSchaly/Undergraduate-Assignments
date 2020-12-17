<ncl id="myNCLDocID" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase id="rgbase1">
			<region height="76.50%" id="rgEsquerda" left="2.00%" top="10.00%" width="47.00%" zIndex="2">
			</region>
			<region height="76.50%" id="rgDireita" left="51.00%" top="10.00%" width="47.00%" zIndex="2">
			</region>
			<region height="10.00%" id="rgBaixo" left="2.00%" top="88.00%" width="96.00%" zIndex="2">
			</region>
		</regionBase>
		<descriptorBase id="descriptorBase1">
			<descriptor id="dVideo1" region="rgEsquerda">
			</descriptor>
			<descriptor id="dVideo2" region="rgDireita">
			</descriptor>
			<descriptor id="dVideo3" region="rgBaixo">
			</descriptor>
		</descriptorBase>
		<connectorBase id="connectorBase1">
			<causalConnector id="onEndStart">
				<simpleCondition role="onEnd">
				</simpleCondition>
				<simpleAction role="start">
				</simpleAction>
			</causalConnector>
			<causalConnector id="onBeginStart">
				<simpleCondition role="onBegin">
				</simpleCondition>
				<simpleAction role="start">
				</simpleAction>
			</causalConnector>
		</connectorBase>
	</head>
	<body id="pInicio">
		<media descriptor="dVideo1" id="video1" src="media/video1.mpg" type="video/mpeg">
			<property name="explicitDur" value="8s">
			</property>
		</media>
		<media descriptor="dVideo1" id="video2" src="media/video2.mpg" type="video/mpeg">
			<property name="explicitDur" value="10s">
			</property>
		</media>
		<media descriptor="dVideo3" id="legenda1" src="media/legenda1.txt" type="text/plain">
			<property name="explicitDur" value="8s">
			</property>
			<property name="background" value="white">
			</property>
		</media>
		<media descriptor="dVideo3" id="legenda2" src="media/legenda2.txt" type="text/plain">
			<property name="explicitDur" value="10s">
			</property>
			<property name="background" value="white">
			</property>
		</media>
		<media id="audio1" src="media/audio1.mp3" type="audio/mp3">
			<property name="explicitDur" value="10s">
			</property>
		</media>
		<media id="audio2" src="media/audio2.mp3" type="audio/mp3">
			<property name="explicitDur" value="10s">
			</property>
		</media>
		<media descriptor="dVideo2" id="imagem1" src="media/imagem1.jpg" type="image/jpeg">
			<property name="explicitDur" value="10s">
			</property>
		</media>
		<media descriptor="dVideo2" id="imagem2" src="media/imagem2.gif" type="image/gif">
			<property name="explicitDur" value="10s">
			</property>
		</media>
		<port component="video1" id="port1">
		</port>
		<link id="linkI1L2" xconnector="onEndStart">
			<bind component="imagem1" role="onEnd">
			</bind>
			<bind component="legenda2" role="start">
			</bind>
		</link>
		<link id="linkV1V2" xconnector="onEndStart">
			<bind component="video1" role="onEnd">
			</bind>
			<bind component="video2" role="start">
			</bind>
		</link>
		<link id="linkV1L1" xconnector="onBeginStart">
			<bind component="video1" role="onBegin">
			</bind>
			<bind component="legenda1" role="start">
			</bind>
		</link>
		<link id="linkV1I1" xconnector="onBeginStart">
			<bind component="video1" role="onBegin">
			</bind>
			<bind component="imagem1" role="start">
			</bind>
		</link>
		<link id="linkV1A1" xconnector="onBeginStart">
			<bind component="video1" role="onBegin">
			</bind>
			<bind component="audio1" role="start">
			</bind>
		</link>
		<link id="linkA1A2" xconnector="onEndStart">
			<bind component="audio1" role="onEnd">
			</bind>
			<bind component="audio2" role="start">
			</bind>
		</link>
		<link id="linkI1I2" xconnector="onEndStart">
			<bind component="imagem1" role="onEnd">
			</bind>
			<bind component="imagem2" role="start">
			</bind>
		</link>
	</body>
</ncl>
