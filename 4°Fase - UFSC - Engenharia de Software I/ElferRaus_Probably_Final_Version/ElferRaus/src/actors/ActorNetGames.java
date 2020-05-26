package actors;


import control.ElferRaus;
import br.ufsc.inf.leobr.cliente.Jogada;
import br.ufsc.inf.leobr.cliente.OuvidorProxy;
import br.ufsc.inf.leobr.cliente.Proxy;
import br.ufsc.inf.leobr.cliente.exception.ArquivoMultiplayerException;
import br.ufsc.inf.leobr.cliente.exception.JahConectadoException;
import br.ufsc.inf.leobr.cliente.exception.NaoConectadoException;
import br.ufsc.inf.leobr.cliente.exception.NaoJogandoException;
import br.ufsc.inf.leobr.cliente.exception.NaoPossivelConectarException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import model.Move;

/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class ActorNetGames implements OuvidorProxy {
    
    
    private Proxy proxy;
    private ElferRaus controller_game;
    
    public ActorNetGames(ElferRaus controller_game) {
        this.controller_game = controller_game;
        this.proxy = Proxy.getInstance();
        proxy.addOuvinte(this);
    }
    
    
    public boolean connect(String name, String ip_server){
        try {
            proxy.conectar(ip_server, name);
            System.out.println("Connected");
            return true;
        } catch (JahConectadoException ex) {
            Logger.getLogger(ActorNetGames.class.getName()).log(Level.SEVERE, null, ex);
            controller_game.sendMessage("You already are connected!");
            return false;
        } catch (NaoPossivelConectarException ex) {
            Logger.getLogger(ActorNetGames.class.getName()).log(Level.SEVERE, null, ex);
            controller_game.sendMessage("Connection unsucessful!");
            return false;
        } catch (ArquivoMultiplayerException ex) {
            Logger.getLogger(ActorNetGames.class.getName()).log(Level.SEVERE, null, ex);
            controller_game.sendMessage("Can't connect!");
            return false;
        }
        
    }
    
    public boolean disconnect(){
        try {
            proxy.desconectar();
            return true;
        } catch (NaoConectadoException ex) {
            Logger.getLogger(ActorNetGames.class.getName()).log(Level.SEVERE, null, ex);
            controller_game.sendMessage("You are not connected!");
            return false;
        }
    }

    public Proxy getProxy() {
        return proxy;
    }

    public ElferRaus getController_game() {
        return controller_game;
    }
    
    
    public boolean iniciarPartida(int number_players) {
        try {
            proxy.iniciarPartida(number_players);
            return true;
        } catch (NaoConectadoException ex) {
            Logger.getLogger(ActorNetGames.class.getName()).log(Level.SEVERE, null, ex);
            controller_game.sendMessage("You are not connected!");
            return false;
        }
    }
    
    @Override
    public void iniciarNovaPartida(Integer position) {
        controller_game.startNewGame(position);
    }
    
    public ArrayList<String> getPlayers() {
        return (ArrayList<String>) proxy.obterNomeAdversarios();
    }
    

    @Override
    public void finalizarPartidaComErro(String message) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void receberMensagem(String msg) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public void sendMove(Move table) {
        try {
            Jogada move = (Jogada) table;
            proxy.enviaJogada(move);
        } catch (NaoJogandoException ex) {
            Logger.getLogger(ActorNetGames.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    @Override
    public void receberJogada(Jogada jogada) {
        controller_game.treatMove((Move) jogada);
    }

    @Override
    public void tratarConexaoPerdida() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void tratarPartidaNaoIniciada(String message) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

   
   

    
    
}
