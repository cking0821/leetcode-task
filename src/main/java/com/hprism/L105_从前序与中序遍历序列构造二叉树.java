package com.hprism;

import java.util.HashMap;
import java.util.Map;

/**
 * @Title: L105_从前序与中序遍历序列构造二叉树
 * @Description: TODO
 * @Author: beeDT
 * @Date: 2024-02-21 21:32
 */
public class L105_从前序与中序遍历序列构造二叉树 {
    public static void main(String[] args) {

        int[] preorder = {3,9,20,15,7};
        int[] inorder = {9,3,15,20,7};

        L105_从前序与中序遍历序列构造二叉树 temp = new L105_从前序与中序遍历序列构造二叉树();
        TreeNode treeNode = temp.buildTree(preorder, inorder);
        System.out.println(treeNode);

    }

    public TreeNode buildTree(int[] preorder, int[] inorder) throws RuntimeException {
        int preLen = preorder.length;
        int inLen = inorder.length;
        if (preLen != inLen) {
            throw new RuntimeException("无效的输入数据");
        }

        Map<Integer, Integer> map = new HashMap<>(preLen);
        for (int i = 0; i < inLen; i++) {
            map.put(inorder[i], i);
        }
        return buildTree(preorder, 0, preLen - 1, map, 0, inLen - 1);
    }

    /**
     *
     * @param preorder  前序遍历序列
     * @param preLeft   前序遍历序列子区间的左边界，可以取到
     * @param preRight  前序遍历序列子区间的右边界，可以取到
     * @param map       在中序遍历序列里，记录节点值对应的索引，数值与下标对应关系
     * @param inLeft    中序遍历序列子区间的左边界，可以取到
     * @param inRight   中序遍历序列子区间的右边界，可以取到
     * @return
     */
    private TreeNode buildTree(int[] preorder, int preLeft, int preRight, Map<Integer, Integer> map, int inLeft, int inRight) {

        if (preLeft > preRight || inLeft > inRight) {
            return null;
        }

        // 根节点 前序遍历的第一个节点
        int rootVal = preorder[preLeft];
        TreeNode root = new TreeNode(rootVal);
        // 根节点在中序遍历中的位置
        int pIndex = map.get(rootVal);
        root.left = buildTree(preorder, preLeft + 1, pIndex - inLeft + preLeft, map, inLeft, pIndex - 1);
        root.right = buildTree(preorder, pIndex - inLeft + preLeft +1, preRight, map, pIndex + 1, inRight);
        return  root;
    }


    class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {
        }

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }

}


