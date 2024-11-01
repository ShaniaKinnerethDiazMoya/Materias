import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class carrera {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new VentanaCarreras();
            }
        });
    }
}

class Hilo implements Runnable {
    private final Thread t;
    private final String nombre;
    private final JLabel personaje;
    private final JLabel labFinal;
    private final Object lock = new Object();
    private boolean suspended = false;

    public static int lugar;

    public Hilo(String nombre, JLabel personaje, JLabel labFinal) {
        this.nombre = nombre;
        this.personaje = personaje;
        this.labFinal = labFinal;
        t = new Thread(this, nombre);
        t.start();
    }

    @Override
    public void run() {
        int retardo;

        try {
            lugar = 1;
            retardo = (int) (Math.random() * 15) + 1;
            labFinal.setVisible(false);

            personaje.setVisible(true);

            for (int i = 50; i <= 500; i++) {
                synchronized (lock) {
                    while (suspended) {
                        lock.wait();
                    }
                }
                personaje.setLocation(i, personaje.getY());
                Thread.sleep(retardo);
            }

            personaje.setVisible(false);
            labFinal.setVisible(true);
            labFinal.setForeground(Color.white);
            labFinal.setText(nombre + " llego en el lugar " + lugar);
            lugar++;

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void suspendThread() {
        synchronized (lock) {
            suspended = true;
        }
    }

    public void resumeThread() {
        synchronized (lock) {
            suspended = false;
            lock.notify();
        }
    }
}

class VentanaCarreras extends JFrame {
    private Hilo tmorty, trick, tpepinillo;

    public VentanaCarreras() {
        super("Rick y Morty");
        JLabel morty, rick, pepinillo, morty_pos, rick_pos, pepinillo_pos;
        JButton botonIniciar, botonSuspender, botonReanudar;

        setSize(700, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel panel = new JPanel();
        panel.setLayout(null);
        panel.setBackground(new Color(000, 000, 000)); 

        // Primer Imagen
        Image imagenS = new ImageIcon("img/morty1.gif").getImage();
        ImageIcon IconShreck = new ImageIcon(imagenS.getScaledInstance(50, 50, Image.SCALE_DEFAULT));
        morty = new JLabel();
        morty.setIcon(IconShreck);
        morty.setBounds(50, 50, 50, 50);

        // Segunda Imagen
        Image imagenC = new ImageIcon("img/rick1.gif").getImage();
        ImageIcon IconCat = new ImageIcon(imagenC.getScaledInstance(50, 50, Image.SCALE_DEFAULT));
        rick = new JLabel();
        rick.setIcon(IconCat);
        rick.setBounds(50, 100, 50, 50);

        // Tercera Imagen
        Image imagenC2 = new ImageIcon("img/pepinillo1.gif").getImage();
        ImageIcon IconCat2 = new ImageIcon(imagenC2.getScaledInstance(50, 50, Image.SCALE_DEFAULT));
        pepinillo = new JLabel();
        pepinillo.setIcon(IconCat2);
        pepinillo.setBounds(50, 150, 50, 50);

        morty_pos = new JLabel();
        morty_pos.setBounds(50, 50, 350, 50);

        rick_pos = new JLabel();
        rick_pos.setBounds(50, 100, 350, 50);

        pepinillo_pos = new JLabel();
        pepinillo_pos.setBounds(50, 150, 350, 50);

        botonIniciar = new JButton("Iniciar");
        botonIniciar.setBounds(50, 250, 150, 50);
        botonIniciar.setBackground(new Color(144, 238, 144)); 
        botonIniciar.setForeground(Color.BLACK); 
        botonIniciar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                tmorty = new Hilo("Morty", morty, morty_pos);
                trick = new Hilo("Rick", rick, rick_pos);
                tpepinillo = new Hilo("Pepinillo", pepinillo, pepinillo_pos);
            }
        });

        botonSuspender = new JButton("Suspender");
        botonSuspender.setBounds(210, 250, 150, 50);
        botonSuspender.setBackground(new Color(255, 182, 193));
        botonSuspender.setForeground(Color.BLACK); 
        botonSuspender.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (tmorty != null && trick != null && tpepinillo != null) {
                    tmorty.suspendThread();
                    trick.suspendThread();
                    tpepinillo.suspendThread();
                }
            }
        });

        botonReanudar = new JButton("Continuar");
        botonReanudar.setBounds(370, 250, 150, 50);
        botonReanudar.setBackground(new Color(255, 255, 153)); 
        botonReanudar.setForeground(Color.BLACK); 
        botonReanudar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (tmorty != null && trick != null && tpepinillo != null) {
                    tmorty.resumeThread();
                    trick.resumeThread();
                    tpepinillo.resumeThread();
                }
            }
        });

        panel.add(morty);
        panel.add(morty_pos);
        panel.add(rick);
        panel.add(rick_pos);
        panel.add(pepinillo);
        panel.add(pepinillo_pos);
        panel.add(botonIniciar);
        panel.add(botonSuspender);
        panel.add(botonReanudar);

        add(panel);
        setVisible(true);
    }
}
