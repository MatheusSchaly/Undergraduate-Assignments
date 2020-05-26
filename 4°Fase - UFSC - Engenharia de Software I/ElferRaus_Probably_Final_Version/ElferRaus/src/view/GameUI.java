package view;


import actors.ActorPlayer;
import java.awt.Color;
import model.Player;
import java.awt.Desktop;
import java.net.URL;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.*;
import javax.swing.ImageIcon;
import javax.swing.border.Border;
import model.Card;
import model.Deck;
import model.Vectors;

/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class GameUI extends javax.swing.JFrame {

    private ArrayList<Player> list_players;
    private ActorPlayer player;
    private ArrayList<Card> played_cards = new ArrayList();
    private int withdraw_deck = 0;
    private ArrayList<JLabel> name_labels;
    private ArrayList<JPanel> player_panels;
    private ArrayList<JLabel> cards_labels;
    
    
    /**
     * Creates new form MainUI
     */
    public GameUI(ActorPlayer player) {
        this.player = player;
        
    }
    
    

    public void init(ArrayList<Player> list_players) {
        this.list_players = list_players;
        initComponents();
        for (int i = 0; i < list_players.size(); i++){
            System.out.println(list_players.get(i).getName() + " - " + list_players.get(i).getId() + " - " + i);                   
        }
        
        name_labels = new ArrayList();
        player_panels = new ArrayList();
        cards_labels = new ArrayList();
        
//        for (int i = 0; i < list_players.get(0).getCards().size(); i++) {
//            Card c_aux = list_players.get(0).getCards().get(i);
//            System.out.println(c_aux.getColour() + " - " + Integer.toString(c_aux.getNumber()));
//        }
//      
        moveButton.setText("Play");
        
        name_labels.add(name1Label1);
        name_labels.add(name2Label);
        name_labels.add(name3Label);
        name_labels.add(name4Label);
        name_labels.add(name5Label);
        name_labels.add(name6Label);
        
        cards_labels.add(playerCards);
        cards_labels.add(playerCards1);
        cards_labels.add(playerCards5);
        cards_labels.add(playerCards2);
        cards_labels.add(playerCards4);
        cards_labels.add(playerCards3);
        
        
        player_panels.add(player1Panel);
        player_panels.add(player2Panel);
        player_panels.add(player3Panel);
        player_panels.add(player4Panel);
        player_panels.add(player5Panel);
        player_panels.add(player6Panel);
        player1Panel.setVisible(false);
        player2Panel.setVisible(false);
        player3Panel.setVisible(false);
        player4Panel.setVisible(false);
        player5Panel.setVisible(false);
        player6Panel.setVisible(false);
        
        
        System.out.println("chegou aqui");
        updateListCards();
        this.setVisible(true);
        setBorders(0);
        updateUI();
        tipsAndTricks();

    }
    
    public void updateNumberCards() {
        System.out.println("upppdasdsa");
        list_players = player.getController_game().getList_players();
        for (int i = 0; i < list_players.size(); i++){
            name_labels.get(i).setText(list_players.get(i).getName());
//            int cards_len = list_players.get(i).getCards().size();
//            cards_labels.get(i).setText(Integer.toString(cards_len));
            cards_labels.get(i).setText(Integer.toString(list_players.get(i).getNumber_cards()));
            player_panels.get(i).setVisible(true);
        }
    }
    
    
    public void setBorders(int turn_number) {
        Color red = new Color(212, 7, 10);
        Color yellow = new Color(244, 226, 28);
        Color green = new Color(5, 197, 61);
        Border current_border = BorderFactory.createLineBorder(green, 2);
        Border next_border = BorderFactory.createLineBorder(yellow, 2);
        Border whatever_border = BorderFactory.createLineBorder(red, 2);
//        System.out.println("aquiiii" + turn);
        int turn = turn_number % list_players.size();
        int next_turn = (turn_number + 1) % list_players.size();
        for (int i = 0; i < list_players.size(); i++) {
            int id = list_players.get(i).getId();
            if ((turn == id) || (next_turn == id)) {
                if (turn == id) {
                    player_panels.get(i).setBorder(current_border);
                } else {
                    player_panels.get(i).setBorder(next_border);
                }
            } else {
                player_panels.get(i).setBorder(whatever_border);
            }
        }
    }
    
    
    public void updateUI() {
        ArrayList<Vectors> vectors = player.getController_game().getVectors();
        updateNumberCards();
        updateVectors();
        System.out.println("DANDO UPDATE");
        for (int i = 0; i < vectors.size(); i++) {
            Vectors aux = vectors.get(i);
            System.out.println(aux.getLeft() + " - " + aux.isMiddle()+ " - " + aux.getRight());
        }
        
    }
    
    public void updateListCards(){
        DefaultListModel model = new DefaultListModel();
        for (int i = 0; i < list_players.get(0).getCards().size(); i++) {
            Card card = list_players.get(0).getCards().get(i);
            String aux = card.getColour() + " - " + card.getNumber();
            System.out.println(aux);
            model.addElement(aux);
        }
        listCardsUI.setModel(model);
    }
    
    
    
    

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        player1Panel = new javax.swing.JPanel();
        name1Label1 = new javax.swing.JLabel();
        score1Label = new javax.swing.JLabel();
        cards1Label = new javax.swing.JLabel();
        playerCards = new javax.swing.JLabel();
        player6Panel = new javax.swing.JPanel();
        name6Label = new javax.swing.JLabel();
        score6Label = new javax.swing.JLabel();
        cards6Label = new javax.swing.JLabel();
        playerCards3 = new javax.swing.JLabel();
        player4Panel = new javax.swing.JPanel();
        name4Label = new javax.swing.JLabel();
        score4Label = new javax.swing.JLabel();
        cards4Label = new javax.swing.JLabel();
        playerCards2 = new javax.swing.JLabel();
        player3Panel = new javax.swing.JPanel();
        name3Label = new javax.swing.JLabel();
        score3Label = new javax.swing.JLabel();
        cards3Label = new javax.swing.JLabel();
        playerCards5 = new javax.swing.JLabel();
        player2Panel = new javax.swing.JPanel();
        name2Label = new javax.swing.JLabel();
        score2Label = new javax.swing.JLabel();
        cards2Label = new javax.swing.JLabel();
        playerCards1 = new javax.swing.JLabel();
        player5Panel = new javax.swing.JPanel();
        name5Label = new javax.swing.JLabel();
        score5Label = new javax.swing.JLabel();
        cards5Label = new javax.swing.JLabel();
        playerCards4 = new javax.swing.JLabel();
        skipButton = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        listCardsUI = new javax.swing.JList();
        jTextRightRed = new javax.swing.JTextField();
        jTextLeftRed = new javax.swing.JTextField();
        jTextCenterRed = new javax.swing.JTextField();
        jTextLeftYellow = new javax.swing.JTextField();
        jTextCenterYellow = new javax.swing.JTextField();
        jTextRightYellow = new javax.swing.JTextField();
        jTextLeftGreen = new javax.swing.JTextField();
        jTextLeftBlue = new javax.swing.JTextField();
        jTextCenterBlue = new javax.swing.JTextField();
        jTextCenterGreen = new javax.swing.JTextField();
        jTextRightGreen = new javax.swing.JTextField();
        jTextRightBlue = new javax.swing.JTextField();
        moveButton = new javax.swing.JButton();
        drawButton = new javax.swing.JButton();
        menuBar = new javax.swing.JMenuBar();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Elfer Raus");
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        setMinimumSize(new java.awt.Dimension(1038, 740));
        setName("mainUI"); // NOI18N
        setResizable(false);
        setSize(new java.awt.Dimension(1038, 740));
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        player1Panel.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0), 2));

        name1Label1.setText("User");

        score1Label.setText("Score:");

        cards1Label.setText("Cards: ");

        playerCards.setText("0");

        javax.swing.GroupLayout player1PanelLayout = new javax.swing.GroupLayout(player1Panel);
        player1Panel.setLayout(player1PanelLayout);
        player1PanelLayout.setHorizontalGroup(
            player1PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player1PanelLayout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player1PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(name1Label1)
                    .addGroup(player1PanelLayout.createSequentialGroup()
                        .addGroup(player1PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(cards1Label, javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(score1Label, javax.swing.GroupLayout.Alignment.LEADING))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(playerCards, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(84, 84, 84))
        );
        player1PanelLayout.setVerticalGroup(
            player1PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player1PanelLayout.createSequentialGroup()
                .addComponent(name1Label1, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(score1Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player1PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cards1Label)
                    .addComponent(playerCards)))
        );

        getContentPane().add(player1Panel, new org.netbeans.lib.awtextra.AbsoluteConstraints(210, 490, 170, 62));

        player6Panel.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        name6Label.setText("Player 6");

        score6Label.setText("Score: 0");

        cards6Label.setText("Cards: ");

        playerCards3.setText("0");

        javax.swing.GroupLayout player6PanelLayout = new javax.swing.GroupLayout(player6Panel);
        player6Panel.setLayout(player6PanelLayout);
        player6PanelLayout.setHorizontalGroup(
            player6PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player6PanelLayout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player6PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(score6Label)
                    .addComponent(name6Label)
                    .addGroup(player6PanelLayout.createSequentialGroup()
                        .addComponent(cards6Label)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(playerCards3, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(76, 76, 76))
        );
        player6PanelLayout.setVerticalGroup(
            player6PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player6PanelLayout.createSequentialGroup()
                .addComponent(name6Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(score6Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player6PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cards6Label)
                    .addComponent(playerCards3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
        );

        getContentPane().add(player6Panel, new org.netbeans.lib.awtextra.AbsoluteConstraints(440, 10, 170, 62));

        player4Panel.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        name4Label.setText("Player 4");

        score4Label.setText("Score: 0");

        cards4Label.setText("Cards: ");

        playerCards2.setText("0");

        javax.swing.GroupLayout player4PanelLayout = new javax.swing.GroupLayout(player4Panel);
        player4Panel.setLayout(player4PanelLayout);
        player4PanelLayout.setHorizontalGroup(
            player4PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player4PanelLayout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player4PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(score4Label)
                    .addComponent(name4Label)
                    .addGroup(player4PanelLayout.createSequentialGroup()
                        .addComponent(cards4Label)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(playerCards2, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(74, 74, 74))
        );
        player4PanelLayout.setVerticalGroup(
            player4PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player4PanelLayout.createSequentialGroup()
                .addComponent(name4Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(score4Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player4PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cards4Label)
                    .addComponent(playerCards2, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)))
        );

        getContentPane().add(player4Panel, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 130, 170, 62));

        player3Panel.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        name3Label.setText("Player 3");
        name3Label.setToolTipText("");

        score3Label.setText("Score: 0");

        cards3Label.setText("Cards: ");

        playerCards5.setText("0");

        javax.swing.GroupLayout player3PanelLayout = new javax.swing.GroupLayout(player3Panel);
        player3Panel.setLayout(player3PanelLayout);
        player3PanelLayout.setHorizontalGroup(
            player3PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player3PanelLayout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player3PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(score3Label)
                    .addComponent(name3Label)
                    .addGroup(player3PanelLayout.createSequentialGroup()
                        .addComponent(cards3Label)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(playerCards5, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(66, 66, 66))
        );
        player3PanelLayout.setVerticalGroup(
            player3PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player3PanelLayout.createSequentialGroup()
                .addComponent(name3Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(score3Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player3PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cards3Label)
                    .addComponent(playerCards5, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)))
        );

        getContentPane().add(player3Panel, new org.netbeans.lib.awtextra.AbsoluteConstraints(860, 370, 170, 62));

        player2Panel.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        name2Label.setText("Player 2");

        score2Label.setText("Score: ");

        cards2Label.setText("Cards:");

        playerCards1.setText("0");

        javax.swing.GroupLayout player2PanelLayout = new javax.swing.GroupLayout(player2Panel);
        player2Panel.setLayout(player2PanelLayout);
        player2PanelLayout.setHorizontalGroup(
            player2PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player2PanelLayout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player2PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(score2Label)
                    .addComponent(name2Label)
                    .addGroup(player2PanelLayout.createSequentialGroup()
                        .addComponent(cards2Label)
                        .addGap(30, 30, 30)
                        .addComponent(playerCards1, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(55, 55, 55))
        );
        player2PanelLayout.setVerticalGroup(
            player2PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player2PanelLayout.createSequentialGroup()
                .addComponent(name2Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(score2Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(player2PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cards2Label)
                    .addComponent(playerCards1)))
        );

        getContentPane().add(player2Panel, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 370, 170, 62));

        player5Panel.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        name5Label.setText("Player 5");

        score5Label.setText("Score: 0");

        cards5Label.setText("Cards: ");

        playerCards4.setText("0");

        javax.swing.GroupLayout player5PanelLayout = new javax.swing.GroupLayout(player5Panel);
        player5Panel.setLayout(player5PanelLayout);
        player5PanelLayout.setHorizontalGroup(
            player5PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player5PanelLayout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player5PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(score5Label)
                    .addComponent(name5Label)
                    .addGroup(player5PanelLayout.createSequentialGroup()
                        .addComponent(cards5Label)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(playerCards4, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(66, 66, 66))
        );
        player5PanelLayout.setVerticalGroup(
            player5PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(player5PanelLayout.createSequentialGroup()
                .addComponent(name5Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(score5Label, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(player5PanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cards5Label)
                    .addComponent(playerCards4, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)))
        );

        getContentPane().add(player5Panel, new org.netbeans.lib.awtextra.AbsoluteConstraints(860, 130, 170, 62));

        skipButton.setText("Skip");
        skipButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                skipTurn(evt);
            }
        });
        getContentPane().add(skipButton, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 520, 85, -1));

        jScrollPane1.setViewportView(listCardsUI);
        listCardsUI.getAccessibleContext().setAccessibleName("cardsList");

        getContentPane().add(jScrollPane1, new org.netbeans.lib.awtextra.AbsoluteConstraints(390, 560, 270, 110));

        jTextRightRed.setEditable(false);
        jTextRightRed.setBackground(new java.awt.Color(212, 7, 10));
        jTextRightRed.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextRightRed.setForeground(new java.awt.Color(7, 2, 2));
        jTextRightRed.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        getContentPane().add(jTextRightRed, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 80, 85, 110));

        jTextLeftRed.setEditable(false);
        jTextLeftRed.setBackground(new java.awt.Color(212, 7, 10));
        jTextLeftRed.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextLeftRed.setForeground(new java.awt.Color(7, 2, 2));
        jTextLeftRed.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        getContentPane().add(jTextLeftRed, new org.netbeans.lib.awtextra.AbsoluteConstraints(390, 80, 85, 110));

        jTextCenterRed.setEditable(false);
        jTextCenterRed.setBackground(new java.awt.Color(212, 7, 10));
        jTextCenterRed.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextCenterRed.setForeground(new java.awt.Color(7, 2, 2));
        jTextCenterRed.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        jTextCenterRed.setText("11");
        getContentPane().add(jTextCenterRed, new org.netbeans.lib.awtextra.AbsoluteConstraints(480, 80, 85, 110));

        jTextLeftYellow.setEditable(false);
        jTextLeftYellow.setBackground(new java.awt.Color(244, 226, 28));
        jTextLeftYellow.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextLeftYellow.setForeground(new java.awt.Color(7, 2, 2));
        jTextLeftYellow.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        getContentPane().add(jTextLeftYellow, new org.netbeans.lib.awtextra.AbsoluteConstraints(390, 190, 85, 110));

        jTextCenterYellow.setEditable(false);
        jTextCenterYellow.setBackground(new java.awt.Color(244, 226, 28));
        jTextCenterYellow.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextCenterYellow.setForeground(new java.awt.Color(7, 2, 2));
        jTextCenterYellow.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        jTextCenterYellow.setText("11");
        getContentPane().add(jTextCenterYellow, new org.netbeans.lib.awtextra.AbsoluteConstraints(480, 190, 85, 110));

        jTextRightYellow.setEditable(false);
        jTextRightYellow.setBackground(new java.awt.Color(244, 226, 28));
        jTextRightYellow.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextRightYellow.setForeground(new java.awt.Color(7, 2, 2));
        jTextRightYellow.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        getContentPane().add(jTextRightYellow, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 190, 85, 110));

        jTextLeftGreen.setEditable(false);
        jTextLeftGreen.setBackground(new java.awt.Color(5, 197, 61));
        jTextLeftGreen.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextLeftGreen.setForeground(new java.awt.Color(7, 2, 2));
        jTextLeftGreen.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        getContentPane().add(jTextLeftGreen, new org.netbeans.lib.awtextra.AbsoluteConstraints(390, 300, 85, 110));

        jTextLeftBlue.setEditable(false);
        jTextLeftBlue.setBackground(new java.awt.Color(1, 110, 241));
        jTextLeftBlue.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextLeftBlue.setForeground(new java.awt.Color(7, 2, 2));
        jTextLeftBlue.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        getContentPane().add(jTextLeftBlue, new org.netbeans.lib.awtextra.AbsoluteConstraints(390, 410, 85, 110));

        jTextCenterBlue.setEditable(false);
        jTextCenterBlue.setBackground(new java.awt.Color(1, 110, 241));
        jTextCenterBlue.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextCenterBlue.setForeground(new java.awt.Color(7, 2, 2));
        jTextCenterBlue.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        jTextCenterBlue.setText("11");
        getContentPane().add(jTextCenterBlue, new org.netbeans.lib.awtextra.AbsoluteConstraints(480, 410, 85, 110));

        jTextCenterGreen.setEditable(false);
        jTextCenterGreen.setBackground(new java.awt.Color(5, 197, 61));
        jTextCenterGreen.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextCenterGreen.setForeground(new java.awt.Color(7, 2, 2));
        jTextCenterGreen.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        jTextCenterGreen.setText("11");
        getContentPane().add(jTextCenterGreen, new org.netbeans.lib.awtextra.AbsoluteConstraints(480, 300, 85, 110));

        jTextRightGreen.setEditable(false);
        jTextRightGreen.setBackground(new java.awt.Color(5, 197, 61));
        jTextRightGreen.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextRightGreen.setForeground(new java.awt.Color(7, 2, 2));
        jTextRightGreen.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        getContentPane().add(jTextRightGreen, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 300, 85, 110));

        jTextRightBlue.setEditable(false);
        jTextRightBlue.setBackground(new java.awt.Color(1, 110, 241));
        jTextRightBlue.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jTextRightBlue.setForeground(new java.awt.Color(7, 2, 2));
        jTextRightBlue.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        getContentPane().add(jTextRightBlue, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 410, 85, 110));

        moveButton.setPreferredSize(new java.awt.Dimension(60, 31));
        moveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                playCard(evt);
            }
        });
        getContentPane().add(moveButton, new org.netbeans.lib.awtextra.AbsoluteConstraints(670, 555, 80, 31));

        drawButton.setText("Draw");
        drawButton.setPreferredSize(new java.awt.Dimension(60, 31));
        drawButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                drawCard(evt);
            }
        });
        getContentPane().add(drawButton, new org.netbeans.lib.awtextra.AbsoluteConstraints(670, 600, 80, 31));
        setJMenuBar(menuBar);

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents
    
    private void makeAMove(String moveRequested) {
        switch (moveRequested) {
            case "Play":
                playActions();
                break;
            case "Draw":
                drawActions();
                break;
            case "Skip":
                skipActions();
                break;
        }
    } 
    
    private void skipTurn(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_skipTurn
        makeAMove("Skip");
    }//GEN-LAST:event_skipTurn

    private void drawActions() {
        Deck deck = player.getController_game().getDeck();
        if ((deck.getCards().size() > 0) && (withdraw_deck < 3)) {
            Card card = deck.getCards().remove(0);
            list_players.get(0).getCards().add(card);
            updateListCards();
            JOptionPane.showMessageDialog(null, "Drew " + card.getColour() + " - " + Integer.toString(card.getNumber()));
            withdraw_deck++;
            list_players.get(0).updateNumber_cards(1);
            updateNumberCards();
        } else {
            JOptionPane.showMessageDialog(null, "You can't draw anymore cards this turn!");
        }
    }   
    
    private void skipActions() {
        enableButtons(false);
        System.out.println("Deck size antes: " + player.getController_game().getDeck().getCards().size());
//        player.getController_game().getDeck().printpls();
        System.out.println("Cartas pescadas: " + withdraw_deck);
//        player.getController_game().updateDeck(withdraw_deck);
//        System.out.println("Topo no deck depois: " + player.getController_game().getDeck().getCards().get(0).getColour() + " - " + player.getController_game().getDeck().getCards().get(0).getNumber());
        int turn = player.getController_game().getTable().getTurn();
        System.out.println("Turn before: "+ turn);
        turn++;
        player.sendMove(played_cards, withdraw_deck, false, turn);
        played_cards.clear();
        withdraw_deck = 0;
        System.out.println("Turn after: "+ turn);
        setBorders(turn);
    }
    
    private void playCard(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_playCard
        makeAMove("Play");
    }//GEN-LAST:event_playCard

    private void playActions() {
        int i = listCardsUI.getSelectedIndex();
        String aux = listCardsUI.getModel().getElementAt(i).toString();
        JOptionPane.showMessageDialog(null, aux);
        DefaultListModel model = (DefaultListModel) listCardsUI.getModel();
        
        Pattern pattern_colour = Pattern.compile("^\\S+");
        Matcher matcher_colour = pattern_colour.matcher(aux);
        
        Pattern pattern_number = Pattern.compile("[0-9]+");
        Matcher matcher_number = pattern_number.matcher(aux);

        if (matcher_colour.find()) {
            System.out.println(matcher_colour.group(0));
        } 
        
        
        if (matcher_number.find()) {
            System.out.println(matcher_number.group(0));
        } 
        
        Vectors vector = pseudoVectorDict(matcher_colour.group(0));
        System.out.println(matcher_number.group(0));
        
            
        boolean test = can_play(vector, Integer.parseInt(matcher_number.group(0)), matcher_colour.group(0));
        if (test) {
            model.removeElementAt(i);
            played_cards.add(list_players.get(0).getCards().get(i));
            list_players.get(0).getCards().remove(i);
            for (int a = 0; a < list_players.get(0).getCards().size(); a++) {
                Card card = list_players.get(0).getCards().get(a);
                String auxa = card.getColour() + " - " + card.getNumber();
                System.out.println(auxa);
                }
            JOptionPane.showMessageDialog(null, "Success!");
            list_players.get(0).updateNumber_cards(-1);
            updateUI();
            if (list_players.get(0).getNumber_cards() == 0) {
                this.sendWinnerMessage(list_players.get(0).getId());
                System.exit(0);
            }
        }
        else {
            JOptionPane.showMessageDialog(null, "You cant play this card!");
        }
    }
    
    private void drawCard(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_drawCard
        makeAMove("Draw");       
    }//GEN-LAST:event_drawCard

    private Vectors pseudoVectorDict(String colour) {
        ArrayList<Vectors> vectors = player.getController_game().getVectors();
        int size = vectors.size();
        for (int i = 0; i < size; i++) {
            Vectors vector = vectors.get(i);
            String aux = vector.getColour();
            if (aux.equals(colour)) {
                return vector;
            }
        }
        return null;
    }
    
    public void enableButtons(boolean is_turn) {
        moveButton.setEnabled(is_turn);
        drawButton.setEnabled(is_turn);
        skipButton.setEnabled(is_turn);       
    }    
    
    private boolean can_play(Vectors vector, int number, String colour) { 
        ArrayList<Vectors> vectors = player.getController_game().getVectors();
        
        if ((vectors.get(0).isMiddle() == false)) {
            if ((number == 11) && (colour.equals("Red"))) {
                vector.setMiddle(true);
                return true;
            }
            else {
                return false;
            }
        }

        if (number == 11) {
            vector.setMiddle(true);
            return true;
        }
        if (vector.isMiddle()) {
            if (number < 11) {
                int left_number = vector.getLeft();
                if (left_number - 1 == number) {
                    vector.setLeft(number);
                    return true;
                    }
                }   
            if (number > 11) {
                int right_number = vector.getRight();
                if (right_number + 1 == number) {
                    vector.setRight(number);
                    return true;
                    }
                }            
            }
        
        return false;
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(GameUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(GameUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(GameUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(GameUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel cards1Label;
    private javax.swing.JLabel cards2Label;
    private javax.swing.JLabel cards3Label;
    private javax.swing.JLabel cards4Label;
    private javax.swing.JLabel cards5Label;
    private javax.swing.JLabel cards6Label;
    private javax.swing.JButton drawButton;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextField jTextCenterBlue;
    private javax.swing.JTextField jTextCenterGreen;
    private javax.swing.JTextField jTextCenterRed;
    private javax.swing.JTextField jTextCenterYellow;
    private javax.swing.JTextField jTextLeftBlue;
    private javax.swing.JTextField jTextLeftGreen;
    private javax.swing.JTextField jTextLeftRed;
    private javax.swing.JTextField jTextLeftYellow;
    private javax.swing.JTextField jTextRightBlue;
    private javax.swing.JTextField jTextRightGreen;
    private javax.swing.JTextField jTextRightRed;
    private javax.swing.JTextField jTextRightYellow;
    private javax.swing.JList listCardsUI;
    private javax.swing.JMenuBar menuBar;
    private javax.swing.JButton moveButton;
    private javax.swing.JLabel name1Label1;
    private javax.swing.JLabel name2Label;
    private javax.swing.JLabel name3Label;
    private javax.swing.JLabel name4Label;
    private javax.swing.JLabel name5Label;
    private javax.swing.JLabel name6Label;
    private javax.swing.JPanel player1Panel;
    private javax.swing.JPanel player2Panel;
    private javax.swing.JPanel player3Panel;
    private javax.swing.JPanel player4Panel;
    private javax.swing.JPanel player5Panel;
    private javax.swing.JPanel player6Panel;
    private javax.swing.JLabel playerCards;
    private javax.swing.JLabel playerCards1;
    private javax.swing.JLabel playerCards2;
    private javax.swing.JLabel playerCards3;
    private javax.swing.JLabel playerCards4;
    private javax.swing.JLabel playerCards5;
    private javax.swing.JLabel score1Label;
    private javax.swing.JLabel score2Label;
    private javax.swing.JLabel score3Label;
    private javax.swing.JLabel score4Label;
    private javax.swing.JLabel score5Label;
    private javax.swing.JLabel score6Label;
    private javax.swing.JButton skipButton;
    // End of variables declaration//GEN-END:variables

    private void updateVectors() {
        ArrayList<Vectors> vectors = player.getController_game().getVectors();
        int size = vectors.size();
//        int r = 0;
//        int g = 0;
//        int b = 0;
        for (int i = 0; i < size; i++) {
            Vectors vector = vectors.get(i);
            String colour = vector.getColour();
            
            switch (colour) {
                case "Red":
                    if (!vector.isMiddle()) {
//                        r = 122;
//                        g = 37;
//                        b = 37;
                        jTextCenterRed.setText("");                        
                    } else {
//                        r = 212;
//                        g = 7;
//                        b = 10;
                        jTextCenterRed.setText("11");
                        if (vector.getLeft() != 11) {
                            jTextLeftRed.setText(Integer.toString(vector.getLeft()));
                        }
                        if (vector.getRight() != 11) {
                            jTextRightRed.setText(Integer.toString(vector.getRight()));    
                        }
                    }
//                    Color c = new Color(r, g, b);
//                    jTextCenterRed.setBackground(c);
//                    jTextLeftRed.setBackground(c);
//                    jTextRightRed.setBackground(c);
                    break;

                case "Blue":
                    if (!vector.isMiddle()) {
//                        r = 37;
//                        g = 86;
//                        b = 122;
                        jTextCenterBlue.setText("");

                    } else {
//                        r = 1;
//                        g = 110;
//                        b = 241;
                        jTextCenterBlue.setText("11");
                        if (vector.getLeft() != 11) {
                            jTextLeftBlue.setText(Integer.toString(vector.getLeft()));
                        }
                        if (vector.getRight() != 11) {
                            jTextRightBlue.setText(Integer.toString(vector.getRight()));
                        }
                    }
////                    Color cb = new Color(r, g, b);
//                    jTextCenterBlue.setBackground(cb);
//                    jTextLeftBlue.setBackground(cb);
//                    jTextRightBlue.setBackground(cb);
                    break;
                    
                case "Green":
                    if (!vector.isMiddle()) {
//                        r = 37;
//                        g = 122;
//                        b = 63;
                        jTextCenterGreen.setText("");
                    } else {
//                        
                        jTextCenterGreen.setText("11");
                        if (vector.getLeft() != 11) {
                            jTextLeftGreen.setText(Integer.toString(vector.getLeft()));
                        }
                        if (vector.getRight() != 11) {
                            jTextRightGreen.setText(Integer.toString(vector.getRight()));
                        }
                    }
//                    Color cx = new Color(r, g, b);
//                    jTextCenterGreen.setBackground(cx);
//                    jTextLeftGreen.setBackground(cx);
//                    jTextRightGreen.setBackground(cx);
                    break;
                   
                case "Yellow":
                    if (!vector.isMiddle()) {
//                        r = 218;
//                        g = 213;
//                        b = 86;
                        jTextCenterYellow.setText("");
                    } else {
//                        r = 244;
//                        g = 226;
//                        b = 28;
                        jTextCenterYellow.setText("11");
                        if (vector.getLeft() != 11) {
                            jTextLeftYellow.setText(Integer.toString(vector.getLeft()));
                        }
                        if (vector.getRight() != 11) {
                            jTextRightYellow.setText(Integer.toString(vector.getRight()));
                        }
                    }
//                    Color cd = new Color(r, g, b);
//                    jTextCenterYellow.setBackground(cd);
//                    jTextLeftYellow.setBackground(cd);
//                    jTextRightYellow.setBackground(cd);
                    break;
                    
            }
            
        }
    }

    public void sendWinnerMessage(int id_player) {
        for (int i = 0; i < list_players.size(); i++) {
            Player p = list_players.get(i);
            if (p.getId() == id_player) {
                JOptionPane.showMessageDialog(null, "Congratulations to " + p.getName() + "!\nFirst to run out of cards!");
                this.setVisible(false);
                skipActions();
                this.dispose();
                
            }
        }
    }
    
    public void sendScoreMessage(int score) {
        JOptionPane.showMessageDialog(null, "Don't worry! Write down your score: " + score);
    }

    private void tipsAndTricks() {
        String tipsandtricks = "*To play a card, select it and press 'Play'."
                + "\n*To draw a card, press 'Draw'."
                + "\n*To end your turn, press 'Skip'."
                + "\n*You can play several cards per turn, be smart!"
                + "\n*You can draw only three cards per turn.";
        JOptionPane.showMessageDialog(null, tipsandtricks, "Tips and Tricks", JOptionPane.INFORMATION_MESSAGE);
    }
}
