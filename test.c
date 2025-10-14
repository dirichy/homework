#include <stdio.h>
#include <stdlib.h>

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
void I_am_father(int node, int **pair_tbl, int *parent_tbl) {
  printf("love%d,%d\n", node, parent_tbl[node]);
  for (int i = 0; i < pair_tbl[node][0]; i++) {
    if (pair_tbl[node][i + 1] != parent_tbl[node]) {
      parent_tbl[pair_tbl[node][i + 1]] = node;
      printf("%d is child of %d", pair_tbl[node][i + 1], node);
      I_am_father(pair_tbl[node][i + 1], pair_tbl, parent_tbl);
    }
  }
}

int path_len(int nodex, int nodey, int *parent_tbl) {
  printf("shit%d,%d\n", nodex, nodey);
  int z = nodex, len_x = 0, len_y = 0;
  while (z != nodey && z != 1) {
    len_x++;
    z = parent_tbl[z];
  }
  printf("%d len_x\n", len_x);
  if (z == nodey) {
    return len_x;
  }
  z = nodey;
  while (z != nodex && z != 1) {
    len_y++;
    // printf("fuck%d,%d\n", z, parent_tbl[z]);
    z = parent_tbl[z];
  }
  printf("%d len_y\n", len_y);
  if (z == nodex) {
    return len_y;
  }
  return len_x + len_y;
}
int mod_pow(int a, int n, int m) {
  int result = 1 % m; // 处理 m = 1 的情况
  int base = a % m;

  while (n > 0) {
    if (n & 1) // 如果当前最低位是1
      result = (result * base) % m;
    base = (base * base) % m; // 平方
    n >>= 1;                  // n除以2
  }

  return result;
}
int *assignEdgeWeights(int **edges, int edgesSize, int *edgesColSize,
                       int **queries, int queriesSize, int *queriesColSize,
                       int *returnSize) {
  int n = edgesSize + 1;
  int n_add_1 = n + 1;
  int *parent_tbl = (int *)malloc(sizeof(int) * n_add_1);
  // pair_tbl
  // pair_tbl[i][j]
  int **pair_tbl = (int **)malloc(sizeof(int *) * n_add_1);
  int *first = (int *)malloc(sizeof(int *) * n_add_1 * n_add_1);
  int *answer = (int *)malloc(sizeof(int) * queriesSize);
  printf("2\n");
  for (int i = 0; i < n_add_1; i++) {
    pair_tbl[i] = first + i * n_add_1;
    pair_tbl[i][0] = 0;
    parent_tbl[i] = -1;
  }
  parent_tbl[1] = 1;
  printf("3\n");
  int x, y;
  for (int i = 0; i < edgesSize; i++) {
    printf("%d,0\n", i);
    x = edges[i][0];
    y = edges[i][1];
    printf("fuck%d\n", edges[0][0]);
    printf("%d,0.5\n", i);
    printf("%d\n", x);
    printf("%d,%d\n", pair_tbl[x][0], x);
    pair_tbl[x][pair_tbl[x][0] + 1] = y;
    printf("%d,0.6\n", i);
    pair_tbl[x][0]++;
    printf("%d,0.7\n", i);
    pair_tbl[y][pair_tbl[y][0] + 1] = x;
    pair_tbl[y][0]++;
    printf("%d,1\n", i);
    if (parent_tbl[x] >= 0) {
      parent_tbl[y] = x;
      I_am_father(y, pair_tbl, parent_tbl);
    } else if (parent_tbl[y] >= 0) {
      parent_tbl[x] = y;
      I_am_father(x, pair_tbl, parent_tbl);
    }
    printf("%d,3\n", i);
  }
  for (int i = 0; i < n_add_1; i++) {
    printf("%d's father is %d\n", i, parent_tbl[i]);
  }
  printf("4\n");
  for (int i = 0; i < queriesSize; i++) {
    printf("wyy\n");
    x = queries[i][0];
    y = queries[i][1];
    int len = path_len(x, y, parent_tbl);
    if (len == 0) {
      answer[i] = 0;
    } else {
      answer[i] = mod_pow(2, len - 1, 10 ^ 9 + 7);
    }
  }
  //   int *parent_tbl = (int *)malloc(sizeof(int) * n_add_1);
  // // pair_tbl
  // // pair_tbl[i][j]
  // int **pair_tbl = (int **)malloc(sizeof(int *) * n_add_1);
  // int *first = (int *)malloc(sizeof(int *) * n_add_1 * n_add_1);
  free(parent_tbl);
  free(pair_tbl);
  free(first);
  *returnSize = queriesSize;
  return answer;
}
int main() {
  int e1[] = {1, 2};
  int e2[] = {1, 3};
  int e3[] = {3, 4};
  int e4[] = {3, 5};
  int *edges[] = {e1, e2, e3, e4};
  int q1[] = {1, 4};
  int q2[] = {3, 4};
  int q3[] = {2, 5};
  int *queries[] = {q1, q2, q3};
  printf("1\n");
  printf("shit%d\n", edges[0][0]);
  int len;
  int *answer =
      assignEdgeWeights(edges, 4, edges[1], queries, 3, queries[1], &len);
  for (int i = 0; i < 3; i++) {
    printf("%d-th answer is %d\n", i, answer[i]);
  }
}
