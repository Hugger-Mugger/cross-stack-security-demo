openssl dgst -sha256 -verify public.pem -signature rust-service.sig rust-service/target/release/rust-service
if [ $? -eq 0 ]; then
  echo "Signature valid, running program..."
  ./rust-service/target/release/rust-service
else
  echo "Signature invalid, aborting!"
fi

