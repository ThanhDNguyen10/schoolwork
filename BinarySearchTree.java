/*
 * IT 306:  Assignment 5 
 * Implementation of a Binary Search Tree 
 */

/**
 *
 * @author Sharmin Sultana
 */
public class BinarySearchTree {
    // Root of BST
    Node root;
    private int size = 0;
    // Constructor
    BinarySearchTree(){
         root = null;
    }
 
    /* A recursive function to insert a new node in BST */
    
    public int add(int k){
         root = addNode(this.root, k);
         size++;
         return root.key;
    }
    Node addNode(Node root, int key)
    {
        if (root == null){
            root = new Node(key);
            return root;
        }
        if (key < root.key)
            root.left = addNode(root.left, key);
        else if (key > root.key)
            root.right = addNode(root.right, key);
        else
            throw new IllegalArgumentException("Insertion failed. Node key " + key + " already exists. \n");
        return root;
    }
    
    // delete a node from the BST. Implement all the three cases for deletion. 
    public int remove(int k){
        root= delete(root,k);
        return k;
    }  
    Node delete(Node root, int key) { 
        if (root == null) return root;
        if (key < root.key) root.left = delete(root.left,key);
        else if (key > root.key) root.right = delete(root.right,key);
        else {
           //0 child
           if (root.left == null && root.right == null) return root;
        
           //1 child
           if (root.left == null) return root.right;
           else if (root.right == null) return root.left;
           
           //2 children
           root.key = findMin();
           root.right = delete(root.right, root.key);
         }
         return root;  
    }
    
    // search for a node with a key k. return the key if found; else throw an exeption
    public int search(int k){
        root= searchKey(root,k);
        return k;   
    }
    Node searchKey (Node root, int k) throws NullPointerException, IllegalArgumentException{
           if (root.key==k) return root;
           else if (root.key>k) root.left= searchKey(root.left,k);
           else if (root.key<k) root.right = searchKey(root.right,k);
           else {throw new IllegalArgumentException("Not found!");}
        return root;
    }    
    
    // find and return the minimum key of the tree
    public int findMin(){
        Node c = root;
        while (c.left != null) {
           c = c.left;
        }
        return c.key;   
    }
    
    // find and return the maximum key of the tree
    public int findMax (){
        Node c = root;
        while (c.right != null) {
           c = c.right;
        }
        return c.key; 
    }
    // Tests if the list is empty. return true if Tree is empty; else false 
    public boolean isEmpty(){
        return size==0;
    }
    //Returns the number of elements in the tree
    public int size(){
        return size;
    } 
    
    // print tree nodes in an inorder traversal 
    public void diplayInorder(){
        inorder(root);   
    }
    public void inorder(Node root) {
        if (isEmpty( )) throw new IllegalStateException("Tree is empty");
        if (root != null) {
           inorder(root.left);
           System.out.print(root.key+ " ");
           inorder(root.right);}
    }
    
    private class Node {

        private Node left;
        private Node right;
        private int key;

        private Node(int data) {
            this.key = data;
            left = right = null;
        }
    }
 
}