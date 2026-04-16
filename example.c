
#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#include <simple-xcipher/simple-xcipher.h>

#define PLAINTEXT "Hello."

int main (){

  size_t encrypteddatasize;
  simple_xcipher_calc_encrypted_data_size(sizeof(PLAINTEXT), &encrypteddatasize);

  uint8_t encrypteddata[encrypteddatasize];
  simple_xcipher_encrypt(PLAINTEXT, sizeof(PLAINTEXT), 0x123, encrypteddata, encrypteddatasize);
  printf("encrypted = ");
  fwrite(encrypteddata, encrypteddatasize, 1, stdout);
  putc('\n', stdout);

  uint8_t decrypteddata[sizeof(PLAINTEXT)];
  simple_xcipher_decrypt(0, sizeof(PLAINTEXT), encrypteddata, encrypteddatasize, 0x123, decrypteddata);
  printf("decrypted = %s\n", decrypteddata);

  return 0;

}
