#include "boost.h"

#include <fstream>
#include <iostream>
#include <vector>
#include <boost/iostreams/filtering_streambuf.hpp>
#include <boost/iostreams/copy.hpp>
#include <boost/iostreams/filter/zlib.hpp>

void pack()
{            
    std::ofstream file("hello.z", std::ios_base::out | std::ios_base::binary);

    boost::iostreams::filtering_streambuf<boost::iostreams::output> out;
    out.push(boost::iostreams::zlib_compressor());

    out.push(file);       
    char data[5] = {'a', 'b', 'c', 'd', 'e'};    
    boost::iostreams::copy(boost::iostreams::basic_array_source<char>(data, sizeof(data)), out);
}

void unpack()
{
    std::fstream file("hello.z", std::ios_base::in | std::ios_base::binary);

    boost::iostreams::filtering_streambuf<boost::iostreams::input> in;
    in.push(boost::iostreams::zlib_decompressor());

    in.push(file);
    boost::iostreams::copy(in, std::cout);
}
