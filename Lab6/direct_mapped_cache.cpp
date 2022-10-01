//#include "direct_mapped_cache.h"
#include "string"
#include <fstream>
#include <iostream>
#include <iomanip>
using namespace std;

void print_cache(long long** p, int d1, int d2) {
    for (int i = 0; i < d1; i++) {
        for (int k = 0; k < d2; k++) {
            cout << p[i][k] << " ";
        }
        cout << "\n";
        cout << endl;
    }
}

long long** create_cache(int d1, int d2) {
    long long** p = new long long*[d1];
    for (int i = 0; i < d1; i++){
        p[i] = new long long [d2];
		p[i][0] = 0;
    }
    return p;
}

bool hit_judge(long long** cache, long long block, long long tag, int total_num) {
    if (cache[block][0] && (cache[block][1] == tag)) {
        return true; 
    }
    cache[block][0] = 1;
    cache[block][1] = tag;
    return false;
}

void delete_catch(long long** p, int d1, int d2) {
    for (int i = 0; i < d1; i++) {
        delete[] p[i]; 
    }
    delete[] p;
}

float direct_mapped(std::string filename, int block_size, int cache_size)
{
    int total_num = 0;
    int hit_num = 0;
    
    int num_of_block = cache_size  / block_size;
    //int num_of_set = num_of_block / way;
    long long addr;
    long long block;
    long long tag;
    //long long*** cache = create_cache(num_of_set, way, 3);
    long long** cache = create_cache(num_of_block, 2);
    bool hj = 0;
    fstream fin;
    fin.open(filename, ios::in);
//    cout << way << "-way catch: " << endl;
//    cout << "block_size: " << block_size << endl;
//    cout << "cache_size: " << cache_size << endl;
//    cout << "# of set: "   << num_of_set << endl << endl;
    
    while (fin >> hex >> addr) {
        total_num++;
        block = (addr / block_size) % num_of_block;
        tag = (addr / block_size) / num_of_block;
        if (hit_judge(cache, block, tag, total_num)) {
            hit_num++;
 //           hj = 1;
        }
//        else {
//            hj = 0;
//        }
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
    //delete_catch(cache, num_of_set, way, 3);
    delete_catch(cache, num_of_block, 2);
//    cout << "total number is " << total_num << endl;
//    cout << "hit time is " << hit_num << endl;
  
    return (float)hit_num/total_num;
}

int main(int argc,char *argv[])
{
    string file = "testcase.txt";
    int direct_map_cache_list[4] = {4096, 16384, 65536, 262144};
    int direct_map_block_list[5] = {16, 32, 64, 128, 256};
    float direct_map_hit_ratio[4][5] = {0};


    /* compute and record direct_mapped results */
    cout<<"============================ Direct mapped result ============================"<<"\n\n";
    for(int cache_idx=0; cache_idx<4; cache_idx++)
    {
        for(int block_idx=0; block_idx<5; block_idx++)
        {
            //cout<<"Cache size: "<< direct_map_cache_list[cache_idx] << endl;
            //cout<<"Block size: "<< direct_map_block_list[block_idx] << endl;  
            direct_map_hit_ratio[cache_idx][block_idx] = direct_mapped(file, direct_map_block_list[block_idx], direct_map_cache_list[cache_idx]);
        }
    }

    /*print results*/
    for(int cache_idx=0; cache_idx<4; cache_idx++)
    {
        for(int block_idx=0; block_idx<5; block_idx++)
        {
            /*print miss ratio*/
            cout<<setw(10)<< 1-direct_map_hit_ratio[cache_idx][block_idx]<<" ";
        }
        cout<<"| "<<direct_map_cache_list[cache_idx]<<"\n";
    }
    cout<<string( 5 * 11, '-' )<<"\n";
    for (int block_idx=0; block_idx<5; block_idx++) cout<<setw(10)<<direct_map_block_list[block_idx]<<" ";
    cout<<"\n\n";

    return 0;
}
