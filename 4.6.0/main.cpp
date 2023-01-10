#include <iostream>
#include <opencv2/core/utility.hpp>

int main() {
    std::cout << "version from header:" << CV_VERSION << std::endl;
    std::cout << "version from lib:" << cv::getVersionString() << std::endl;

    return 0;
}
