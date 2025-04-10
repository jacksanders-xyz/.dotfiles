export const refreshFrequency = 60000;

// export const command = "echo 'woosher_returner'";

export const className = `
  position: fixed;
  bottom: 20px;
  right: 20px;
  background: rgba(0, 0, 0, 0.7);
  color: #fff;
  padding: 10px 15px;
  border-radius: 5px;
  font-family: sans-serif;
  font-size: 14px;
  z-index: 9999;
`;

export const render = ({ output }) => {
  return `woosher_returner`;
};
