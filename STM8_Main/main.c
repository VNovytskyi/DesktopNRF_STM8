/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"
#include "sheller.h"

#define SHELLER_DATA_LENGTH 8
sheller_t shell;
uint8_t receiveBuffer[SHELLER_DATA_LENGTH];
uint8_t transmitBuffer[SHELLER_DATA_LENGTH + SHELLER_SERVICE_BYTES_COUNT];

uint8_t transmitMessageIndex;
uint8_t transmitMessage[SHELLER_DATA_LENGTH];

static void CLK_Config(void);
static void GPIO_Config(void);
static void UART1_Config(void);
static void Sheller_Config(void);
static void delay_ticks(uint32_t t);

@far @interrupt void UART1_RX_IRQ(void);

void main()
{
	CLK_Config();
	GPIO_Config();
	UART1_Config();
	Sheller_Config();
	
	enableInterrupts();
	while (1) {
		if (sheller_read(&shell, receiveBuffer) == SHELLER_OK) {
			GPIO_WriteReverse(GPIOB, GPIO_PIN_5);
			transmitMessage[0] = 12;
			transmitMessage[1] = 54;
			transmitMessage[2] = 221;
			sheller_wrap(&shell, transmitMessage, 3, transmitBuffer);
			for (transmitMessageIndex = 0; transmitMessageIndex < (SHELLER_DATA_LENGTH + SHELLER_SERVICE_BYTES_COUNT); ++transmitMessageIndex) {
				UART1_SendData8(transmitBuffer[transmitMessageIndex]);
				while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
			}
		}
	}
}

@far @interrupt void UART1_RX_IRQ(void) 
{
	sheller_push(&shell, UART1_ReceiveData8());
	
	if (UART1_GetFlagStatus(UART1_FLAG_OR) == SET) {
		UART1_ReceiveData8();
	}
}

static void CLK_Config(void)
{
	CLK_DeInit();
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);	
}

static void GPIO_Config(void)
{
	GPIO_DeInit(GPIOB);
	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);
}

static void UART1_Config(void)
{
	UART1_DeInit();
	UART1_Init(9600, 
							UART1_WORDLENGTH_8D, 
							UART1_STOPBITS_1, 
							UART1_PARITY_NO, 
							UART1_SYNCMODE_CLOCK_DISABLE, 
							UART1_MODE_TXRX_ENABLE);
	
	//UART1_ITConfig(UART1_IT_TXE, ENABLE);
	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
	UART1_Cmd(ENABLE);	
}

static void Sheller_Config(void)
{
	uint8_t init_result = sheller_init(&shell, 0x23, SHELLER_DATA_LENGTH, 128);
	if (init_result == SHELLER_ERROR) {
		while(1);
	}
}

static void delay_ticks(uint32_t t) {
    while(--t);
}

#ifdef USE_FULL_ASSERT
void assert_failed(uint8_t* file, uint32_t line)
{
  while (1)
  {
  }
}
#endif