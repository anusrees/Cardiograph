#include "crypto.h"

#include <QDebug>

QString encrypt_decrypt( std::string text, std::string key,
                         bool encrypt )
{
    char c;
    int split[7], sel, k;
    std::string cipher(text);
    size_t key_size = key.length();
    size_t text_size = text.length();

    for(size_t i=0; i<text_size; i+=key_size)
    {
        size_t limit = text_size-i;
        limit = limit<key_size ? limit : key_size;
        for(int j=0; j<limit; j++)
        {
            if(encrypt)
                c = text[i+j]^key[j];
            else
                c = text[i+limit-1-j];

            for(k=0; k<7; k++)
            {
                split[k] = c&1;
                c = c>>1;
            }

            sel = key[j]&3;

            switch(sel)
            {
            case 0:
                for(k=0; k<3; k++)
                {
                    int tmp = split[k];
                    split[k] = split[6-k];
                    split[6-k] = tmp;
                }
                break;
            case 1:
                for(k=0; k<3; k++)
                {
                    int tmp = split[k];
                    split[k] = split[k+3];
                    split[k+3] = tmp;
                }
                break;
            case 2:
                for(k=0; k<7; k++)
                    split[k] = !split[k];
                break;
            case 3:
                for(int k=0; k<6; k+=2)
                {
                    int tmp = split[k];
                    split[k] = split[k+1];
                    split[k+1] = tmp;
                }
                break;
            default:
                break;
            }

            c = 0;
            for(k=0; k<7; k++)
                c += split[k]<<k;

            if(encrypt)
                cipher[limit-1-j+i] = c;
            else
                cipher[i+j] = c^key[j];
        }
    }

    return QString::fromStdString(cipher);
}
