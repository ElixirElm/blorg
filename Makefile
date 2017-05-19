E4_DIR=./web/e4

e4ToJs:
	$(MAKE) -C $(E4_DIR)

clean:
	$(MAKE) -C $(E4_DIR) clean
