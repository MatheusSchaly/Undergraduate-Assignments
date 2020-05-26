package view;


import actors.ActorPlayer;
import java.awt.Desktop;
import java.net.URL;
import java.util.ArrayList;
import javax.swing.*;
import javax.swing.ImageIcon;

/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class HomeUI extends javax.swing.JFrame {
    int players_number = 0;
    int players_count = 0;
    private ActorPlayer player;
    
    public HomeUI(ActorPlayer player) {
        initComponents();
        this.player = player;
    }
    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane2 = new javax.swing.JScrollPane();
        jTextArea2 = new javax.swing.JTextArea();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTextArea1 = new javax.swing.JTextArea();
        menuBar = new javax.swing.JMenuBar();
        menuPlay = new javax.swing.JMenu();
        menuItemConnect = new javax.swing.JMenuItem();
        menuStart = new javax.swing.JMenu();
        buttonDisconnect = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Elfer Raus");
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        setMinimumSize(new java.awt.Dimension(1038, 740));
        setName("mainUI"); // NOI18N
        setResizable(false);
        setSize(new java.awt.Dimension(1038, 740));
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jScrollPane2.setBackground(new java.awt.Color(105, 105, 105));
        jScrollPane2.setHorizontalScrollBarPolicy(javax.swing.ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
        jScrollPane2.setVerticalScrollBarPolicy(javax.swing.ScrollPaneConstants.VERTICAL_SCROLLBAR_NEVER);

        jTextArea2.setEditable(false);
        jTextArea2.setBackground(new java.awt.Color(146, 146, 146));
        jTextArea2.setColumns(20);
        jTextArea2.setFont(new java.awt.Font("Ubuntu", 1, 48)); // NOI18N
        jTextArea2.setRows(5);
        jTextArea2.setText("ELFER RAUS");
        jScrollPane2.setViewportView(jTextArea2);

        getContentPane().add(jScrollPane2, new org.netbeans.lib.awtextra.AbsoluteConstraints(390, 280, 290, 60));

        jTextArea1.setEditable(false);
        jTextArea1.setBackground(new java.awt.Color(205, 205, 205));
        jTextArea1.setColumns(20);
        jTextArea1.setFont(new java.awt.Font("Ubuntu", 1, 15)); // NOI18N
        jTextArea1.setRows(5);
        jTextArea1.setTabSize(4);
        jTextArea1.setText("Developed by:\n    Francisco Vicenzi\n    Matheus Schaly\n    Uriel Kindermann");
        jScrollPane1.setViewportView(jTextArea1);

        getContentPane().add(jScrollPane1, new org.netbeans.lib.awtextra.AbsoluteConstraints(770, 580, -1, -1));

        menuPlay.setText("Play");

        menuItemConnect.setText("Connect");
        menuItemConnect.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuItemConnectActionPerformed(evt);
            }
        });
        menuPlay.add(menuItemConnect);

        menuBar.add(menuPlay);
        menuPlay.getAccessibleContext().setAccessibleName("PlayMenu");

        menuStart.setText("Start");
        menuStart.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                menuStartMouseClicked(evt);
            }
        });
        menuBar.add(menuStart);

        buttonDisconnect.setText("Disconnect");
        buttonDisconnect.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                buttonDisconnectMouseClicked(evt);
            }
        });
        menuBar.add(buttonDisconnect);

        setJMenuBar(menuBar);

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void buttonDisconnectMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_buttonDisconnectMouseClicked
        int dialogButton = JOptionPane.YES_NO_OPTION;
        int dialogResult = JOptionPane.showConfirmDialog (null, "Confirm disconnection: ",  "Warning",dialogButton);
        if(dialogResult == JOptionPane.YES_OPTION){
            player.disconnect();
        }
    }//GEN-LAST:event_buttonDisconnectMouseClicked

    private void menuStartMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_menuStartMouseClicked
        JTextField number_players = new JTextField(5);
        JPanel myPanel = new JPanel();
        myPanel.add(new JLabel("Number of players:"));
        myPanel.add(number_players);
        JOptionPane.showConfirmDialog(null, myPanel,
            "Configuration:", JOptionPane.OK_CANCEL_OPTION);
        player.startGame(Integer.parseInt(number_players.getText()));
    }//GEN-LAST:event_menuStartMouseClicked
        
    private void menuItemConnectActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuItemConnectActionPerformed
        JTextField name = new JTextField(5);
        JTextField server = new JTextField(5);

        JPanel myPanel = new JPanel();
        myPanel.add(new JLabel("Name:"));
        myPanel.add(name);
        
        myPanel.add(new JLabel("Server:"));
        myPanel.add(server);

        int result = JOptionPane.showConfirmDialog(null, myPanel,
            "Configuration:", JOptionPane.OK_CANCEL_OPTION);
        if (result == JOptionPane.OK_OPTION) {
            JOptionPane.showMessageDialog(null, "Name: " + name.getText());
            JOptionPane.showMessageDialog(null, "Server: " + server.getText());
        }
        
        player.connect(name.getText(), server.getText());      
    }//GEN-LAST:event_menuItemConnectActionPerformed

    
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
            java.util.logging.Logger.getLogger(HomeUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(HomeUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(HomeUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(HomeUI.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JMenu buttonDisconnect;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTextArea jTextArea1;
    private javax.swing.JTextArea jTextArea2;
    private javax.swing.JMenuBar menuBar;
    private javax.swing.JMenuItem menuItemConnect;
    private javax.swing.JMenu menuPlay;
    private javax.swing.JMenu menuStart;
    // End of variables declaration//GEN-END:variables

    public void sendMessageUI(String connection_sucessful_) {
        JOptionPane.showMessageDialog(null, connection_sucessful_);
    }

    
}
