import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_COLS = 40;
public final static int NUM_ROWS = 40;
public int nBombs = 100;
public int realBombs = 0;
void setup ()
{
    size(800, 800);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int rows = 0; rows < NUM_ROWS; rows ++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[rows][c] = new MSButton(rows,c);
        }
    }

    bombs = new ArrayList<MSButton>();
    
    
    
    
    setBombs();
}
public void setBombs()
{
    for(int i = 0; i < nBombs; i++)
    {
        int bRow = (int)(Math.random()*NUM_ROWS);
        int bCol = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[bRow][bCol]))
        {
            bombs.add(buttons[bRow][bCol]); 
            //realBombs += 1;
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 800/NUM_COLS;
         height = 800/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
        {
            if(marked == false)
            {
                clicked = false;
            }
            else 
            {
                clicked = true;     
            }
        }
        else if (bombs.contains(this))
        {
            displayLosingMessage(); 
        }
        else if (countBombs(r,c) > 0) 
        {
            setLabel("" + countBombs(r,c));
        }
        else
        {
            if(isValid(r,c-1) && !buttons[r][c-1].isMarked())
            {
                buttons[r][c-1].mousePressed();
            }
            else if(isValid(r-1,c-1) && !buttons[r-1][c-1].isMarked())
            {
                buttons[r-1][c-1].mousePressed();
            }
            else if(isValid(r-1,c) && !buttons[r-1][c].isMarked())
            {
                buttons[r-1][c].mousePressed();
            }
            else if(isValid(r,c+1) && !buttons[r][c+1].isMarked())
            {
                buttons[r][c+1].mousePressed();
            }
            else if(isValid(r+1,c+1) && !buttons[r+1][c+1].isMarked())
            {
                buttons[r+1][c+1].mousePressed();
            }
            else if(isValid(r+1,c) && !buttons[r+1][c].isMarked())
            {
                buttons[r+1][c].mousePressed();
            }
            else if(isValid(r+1,c-1) && !buttons[r+1][c-1].isMarked())
            {
                buttons[r+1][c-1].mousePressed();
            }
            else if(isValid(r-1,c+1) && !buttons[r-1][c+1].isMarked())
            {
                buttons[r-1][c+1].mousePressed();
            }
            
        }
    }
        //your code here


    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r <= NUM_ROWS && c >= 0 && c <= NUM_COLS)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row+1, col) == true && bombs.contains(buttons[row+1][col]))
        {
            numBombs ++;
        }
        if(isValid(row+1, col+1) == true && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs ++;
        }
        if(isValid(row, col+1) == true && bombs.contains(buttons[row][col+1]))
        {
            numBombs ++;
        }
        if(isValid(row-1, col) == true && bombs.contains(buttons[row-1][col]))
        {
            numBombs ++;
        }
        if(isValid(row, col-1) == true && bombs.contains(buttons[row][col-1]))
        {
            numBombs ++;
        }
        if(isValid(row-1, col-1) == true && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs ++;
        }
        if(isValid(row-1, col+1) == true && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs ++;
        }
        if(isValid(row+1, col-1) == true && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs ++;
        }
        return numBombs;
    }
}
