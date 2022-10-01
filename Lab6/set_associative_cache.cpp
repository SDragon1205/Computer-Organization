//#include "set_associative_cache.h"
#include <string>
#include <fstream>
#include <iostream>
#include <iomanip>
using namespace std;

void print_cache(long long*** p, int d1, int d2, int d3) {
    for (int i = 0; i < d1; i++) {
        for (int j = 0; j < d2; j++) {
            for (int k = 0; k < 3; k++) {
                cout << p[i][j][k] << " ";
            }
            cout << "\t";
        }
        cout << endl;
    }
}

long long*** create_cache(int d1, int d2, int d3) {
    long long*** p = new long long**[d1];
    for (int i = 0; i < d1; i++) {
        p[i] = new long long* [d2];
        for (int j = 0; j < d2; j++) {
            p[i][j] = new long long[d3];
            p[i][j][0] = 0;
        }
    }
    return p;
}

bool hit_judge(long long*** cache, long long set, long long tag, int total_num, int way) {

//  1. hit situation ...
    for (int i = 0; i < way; i++) {
        if (cache[set][i][0] && (cache[set][i][2] == tag)) {
            cache[set][i][1] = total_num;
//            cout << "situation 1." << endl;
            return true; 
        }
    }

//  miss situation
    int min_LRU = 100000;
    int LRU_way = 0;
    for (int i = 0; i < way; i++) {
        if (cache[set][i][0]) {// find LRU
            if (cache[set][i][1] < min_LRU) {
                min_LRU = cache[set][i][1];
                LRU_way = i;
            }
        }

        else {// 2. find blank space(if any)
            cache[set][i][0] = 1;
            cache[set][i][1] = total_num;
            cache[set][i][2] = tag;
//            cout << "s2." << endl;
            return false;
        }
    }

//  3. replace LRU
    cache[set][LRU_way][1] = total_num;
    cache[set][LRU_way][2] = tag;
//    cout << "s3" << endl;
    return false;
}

void delete_catch(long long*** p, int d1, int d2, int d3) {
    for (int i = 0; i < d1; i++) {
        for (int j = 0; j < d2; j++) {
            delete[] p[i][j];
        }
        delete[] p[i]; 
    }
    delete[] p;
}

float set_associative(string filename, int way, int block_size, int cache_size)
{   
    int total_num = 0;
    int hit_num = 0;
    int num_of_block = cache_size  / block_size;
    int num_of_set = num_of_block / way;
    long long addr;
    long long set;
    long long tag;
    long long*** cache = create_cache(num_of_set, way, 3);
    bool hj = 0;
    fstream fin;
    fin.open(filename, ios::in);
//    cout << way << "-way catch: " << endl;
//    cout << "block_size: " << block_size << endl;
//    cout << "cache_size: " << cache_size << endl;
//    cout << "# of set: "   << num_of_set << endl << endl;
    
    while (fin >> hex >> addr) {
        total_num++;
        set = (addr / block_size) % num_of_set;
        tag = (addr / block_size) / num_of_set;
        if (hit_judge(cache, set, tag, total_num, way)) {
            hit_num++;
 //           hj = 1;
        }
        else {
//            hj = 0;
        }
/*        if (total_num < 100 && cache_size == 2048 && way == 1) {
            cout << "addr: " << addr << endl;
            cout << "set: " << set << endl;
            cout << "tag: " << tag << endl;
            if (hj) {
                cout << "this time is hit." << endl;
            }
            else {
                cout << "this time is miss." << endl;
            }
            print_cache(cache, num_of_set, way, 3);
            cout << endl;
        }*/
    }
    delete_catch(cache, num_of_set, way, 3);
//    cout << "total number is " << total_num << endl;
//    cout << "hit time is " << hit_num << endl;
    return (float)hit_num/total_num;
}

int main(int argc,char *argv[])
{
    string file = "testcase.txt";


    int set_ass_cache_list[6] = {1024, 2048, 4096, 8192, 16384, 32768};
    int set_ass_way_list[4] = {1, 2, 4, 8};
    int set_ass_Block_size = 64;
    float set_ass_hit_ratio[6][4] = {0};

    cout<<"===================== N-way set associative result ======================="<<"\n\n"<<"Bloack size: "<<set_ass_Block_size<<"\n\n";
    /* compute and record LRU set_associative results */
    for(int cache_idx=0; cache_idx<6; cache_idx++)
    {
        for(int way_ldx=0; way_ldx<4; way_ldx++)
        {     
            //cout<<"Cache size: "<< set_ass_cache_list[cache_idx] << endl;
            //cout<< set_ass_way_list[way_ldx] << "-way" <<endl;
            set_ass_hit_ratio[cache_idx][way_ldx] = set_associative(file, set_ass_way_list[way_ldx], set_ass_Block_size, set_ass_cache_list[cache_idx]);
        }
    }

    /* print results */
    for(int cache_idx=0; cache_idx<6; cache_idx++)
    {
        for(int way_ldx=0; way_ldx<4; way_ldx++)
        {
            /*print miss ratio*/
            cout<<setw(10)<< 1-set_ass_hit_ratio[cache_idx][way_ldx]<<" ";
        }
        cout<<"| "<<set_ass_cache_list[cache_idx]<<"\n";
    }
    cout<<string( 4 * 11, '-' )<<"\n";
    for (int way_ldx=0; way_ldx<4; way_ldx++) cout<<setw(6)<<set_ass_way_list[way_ldx]<<"-way ";
    cout<<"\n";

    return 0;
}

