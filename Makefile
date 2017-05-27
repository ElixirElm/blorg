E4_DIR=./assets/e4

e4ToJs:
	$(MAKE) -C $(E4_DIR)

clean:
	$(MAKE) -C $(E4_DIR) clean
