#include <iostream> // 引入iostream库，用于输入输出

using namespace std;

const int N=110; // 定义常量N，最大物品数+1
const int M=10005; // 定义常量M，最大总和+1
int f[N][M]; // 定义二维数组f，用于存储动态规划的中间结果

int main()
{
	int n, m, x; // n为物品数，m为目标总和，x用于存储每个物品的值
	cin >> n >> m; // 从标准输入读取n和m
	f[0][0] = 1; // 初始化动态规划的基础情况，没有物品时总和为0的方法只有1种（什么都不取）
	for(int i = 1; i <= n; i++){ // 遍历每个物品
        cin >> x; // 读取当前物品的值
		for(int j = m; j >= 0; j--){ // 从m倒序遍历到0，确保每个物品在每个总和只被计算一次
			f[i][j] = f[i-1][j]; // 不选择当前物品的情况
			if(j >= x) f[i][j] += f[i-1][j-x]; // 选择当前物品的情况，累加到方法数中
		}
	}
	cout << f[n][m]; // 输出使用n个物品组成总和m的方法数量
	return 0;
}
